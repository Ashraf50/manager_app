import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/func/get_token.dart';
import 'package:manager_app/features/chat/presentation/view/widget/chat_bubble.dart';
import 'package:manager_app/features/chat/presentation/view_model/message_cubit/message_cubit.dart';
import 'package:manager_app/generated/l10n.dart';

class MessagesListView extends StatefulWidget {
  final String conversationId;
  final String ticketId;
  const MessagesListView({
    super.key,
    required this.conversationId,
    required this.ticketId,
  });

  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView> {
  late ScrollController _scrollController;
  late MessageCubit messageCubit;
  String? myId;

  @override
  void initState() {
    super.initState();
    messageCubit = context.read<MessageCubit>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    loadMyId();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isTop) {
      messageCubit.loadMoreMessages(
        conversationId: widget.conversationId,
        ticketId: widget.ticketId,
      );
    }
  }

  bool get _isTop {
    if (!_scrollController.hasClients) return false;
    return _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50;
  }

  Future<void> loadMyId() async {
    final id = await getUserId();
    setState(() {
      myId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state is MessageLoaded && state.messages.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.isNewMessages) {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      },
      builder: (context, state) {
        if (state is MessageInitial || state is MessageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MessageLoaded) {
          if (state.messages.isEmpty) {
            return Center(child: Text(S.of(context).no_messages));
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.messages.length,
            reverse: true,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              final isMe = message.user.id == int.tryParse(myId ?? '');
              return InkWell(
                onLongPress: () => _showMessageOptions(
                  context,
                  message.id,
                  widget.conversationId,
                  message.content ?? "",
                ),
                child: isMe
                    ? ChatBubble(message: message)
                    : ChatBubbleFriend(message: message),
              );
            },
          );
        } else if (state is MessageError) {
          return Center(child: Text(state.error));
        }
        return const SizedBox();
      },
    );
  }

  void _showMessageOptions(BuildContext parentContext, String messageId,
      String conversationId, String text) {
    showModalBottomSheet(
      context: parentContext,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.copy),
                title: Text(S.of(context).copy),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: text));
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(S.of(context).delete),
                onTap: () {
                  parentContext.read<MessageCubit>().deleteMessage(
                        conversationId: conversationId,
                        messageId: messageId,
                        deleteForAll: 0,
                      );
                  context.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(S.of(context).delete_for_all),
                onTap: () {
                  parentContext.read<MessageCubit>().deleteMessage(
                        conversationId: conversationId,
                        messageId: messageId,
                        deleteForAll: 1,
                      );
                  context.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
