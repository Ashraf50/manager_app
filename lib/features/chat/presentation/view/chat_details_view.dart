import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/func/get_token.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/chat/data/model/conversation_model/conversation_model.dart';
import 'package:manager_app/features/chat/presentation/view/widget/messages_list_view.dart';
import 'package:manager_app/features/chat/presentation/view_model/cubit/chat_cubit.dart';
import 'package:manager_app/features/chat/presentation/view_model/message_cubit/message_cubit.dart';
import 'package:manager_app/generated/l10n.dart';
import '../view_model/cubit/pusher_cubit.dart';
import 'widget/conversation_app_bar.dart';

class ChatDetailsView extends StatefulWidget {
  final ConversationModel conversation;
  final String ticketId;

  const ChatDetailsView({
    super.key,
    required this.conversation,
    required this.ticketId,
  });

  @override
  State<ChatDetailsView> createState() => _ChatDetailsViewState();
}

class _ChatDetailsViewState extends State<ChatDetailsView> {
  final TextEditingController _controller = TextEditingController();
  bool _isNotEmpty = false;
  late PusherCubit _pusherCubit;
  late MessageCubit _messageCubit;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pusherCubit = context.read<PusherCubit>();
    _messageCubit = context.read<MessageCubit>();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isNotEmpty = _controller.text.trim().isNotEmpty;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final id = await getUserId();
      if (id != null) {
        _pusherCubit.init(
          loggedUserId: id,
          conversationId: widget.conversation.id!,
          onNewMessage: (message) {
              print("New message from Pusher: ${message.content}");
            _messageCubit.addNewMessage(message);
          },
        );
        _messageCubit.fetchMessages(
          conversationId: widget.conversation.id!,
          ticketId: widget.ticketId,
          reset: true,
        );
      }
    });
  }

  @override
  void dispose() {
    final conversationId = widget.conversation.id;
    if (conversationId != null) {
      _pusherCubit.unsubscribeConversation(conversationId);
    }
    _pusherCubit.disconnect();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state is MessageSentSuccess) {
          _messageCubit.addNewMessage(state.message);
        }
      },
      child: CustomScaffold(
        backgroundColor: const Color(0xffF3F2F5),
        appBar: ConversationAppBar(
          userImageUrl: widget.conversation.otherUser!.avatar!,
          userName: widget.conversation.otherUser!.name!,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: MessagesListView(
                conversationId: widget.conversation.id!,
                ticketId: widget.ticketId,
              ),
            ),
            if (_pickedImage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _pickedImage!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _pickedImage = null;
                          });
                        },
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.red,
                          child:
                              Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    return Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) {
                          if (_isNotEmpty || _pickedImage != null) {
                            _messageCubit.sendMessage(
                              conversationId: widget.conversation.id!,
                              ticketId: widget.ticketId,
                              content: _controller.text,
                              type: _pickedImage != null ? 1 : 0,
                              mediaFiles:
                                  _pickedImage != null ? [_pickedImage!] : null,
                            );
                            _controller.clear();
                            setState(() {
                              _pickedImage = null;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.darkBlue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: S.of(context).send_message,
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.image),
                                onPressed: _pickImage,
                              ),
                              if (state is MessageSending)
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              else if (_isNotEmpty || _pickedImage != null)
                                IconButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    _messageCubit.sendMessage(
                                      conversationId: widget.conversation.id!,
                                      ticketId: widget.ticketId,
                                      content: _controller.text,
                                      type: _pickedImage != null ? 1 : 0,
                                      mediaFiles: _pickedImage != null
                                          ? [_pickedImage!]
                                          : null,
                                    );
                                    _controller.clear();
                                    setState(() {
                                      _pickedImage = null;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: AppColors.darkBlue,
                                    size: 30,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
