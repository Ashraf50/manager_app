import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/core/constant/func/get_token.dart';
import 'package:manager_app/features/chat/data/model/message_model/message_model.dart';
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
  int? _selectedIndex;

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
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
            itemBuilder: (context, index) {
              final message = state.messages[index];
              final isMe = message.user.id == int.tryParse(myId ?? '');
              return Builder(
                builder: (messageBubbleContext) {
                  final messageWidget = isMe
                      ? ChatBubble(message: message)
                      : ChatBubbleFriend(message: message);
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: _selectedIndex == index ? 30 : 0,
                    ),
                    child: InkWell(
                      onLongPress: () {
                        final RenderBox box = messageBubbleContext
                            .findRenderObject() as RenderBox;
                        final Offset bubbleOffset =
                            box.localToGlobal(Offset.zero);
                        final double bubbleHeight = box.size.height;
                        final double bubbleWidth = box.size.width;

                        final double screenHeight =
                            MediaQuery.of(context).size.height;
                        final double spaceBelow =
                            screenHeight - bubbleOffset.dy - bubbleHeight;

                        final bool showAbove = spaceBelow < 150;

                        final Offset menuPosition = showAbove
                            ? Offset(
                                bubbleOffset.dx + bubbleWidth / 2,
                                bubbleOffset.dy - 8,
                              )
                            : Offset(
                                bubbleOffset.dx + bubbleWidth / 2,
                                bubbleOffset.dy + bubbleHeight + 8,
                              );

                        setState(() {
                          _selectedIndex = index;
                        });

                        _showCustomMenu(
                          context,
                          menuPosition,
                          bubbleWidth: bubbleWidth,
                          showAbove: showAbove,
                          onClose: () {
                            setState(() {
                              _selectedIndex = null;
                            });
                          },
                          message: message,
                        );
                      },
                      child: messageWidget,
                    ),
                  );
                },
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

  void _showCustomMenu(
    BuildContext context,
    Offset position, {
    required double bubbleWidth,
    required bool showAbove,
    required VoidCallback onClose,
    required MessageModel message,
  }) {
    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (context) => WhatsAppMenuOverlay(
        position: position,
        bubbleWidth: bubbleWidth,
        showAbove: showAbove,
        onCopy: () {
          Clipboard.setData(ClipboardData(text: message.content ?? ""));
          entry?.remove();
          onClose();
        },
        onDelete: () {
          context.read<MessageCubit>().deleteMessage(
                conversationId: widget.conversationId,
                messageId: message.id,
                deleteForAll: 0,
              );
          entry?.remove();
          onClose();
        },
        onDeleteForAll: () {
          context.read<MessageCubit>().deleteMessage(
                conversationId: widget.conversationId,
                messageId: message.id,
                deleteForAll: 1,
              );
          entry?.remove();
          onClose();
        },
        onDismiss: () {
          entry?.remove();
          onClose();
        },
      ),
    );
    Overlay.of(context).insert(entry);
  }
}

class WhatsAppMenu extends StatelessWidget {
  final VoidCallback onCopy;
  final VoidCallback onDelete;
  final VoidCallback onDeleteForAll;

  const WhatsAppMenu({
    required this.onCopy,
    required this.onDelete,
    required this.onDeleteForAll,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _menuItem(Icons.copy, S.of(context).copy, onCopy, color: Colors.black),
            _menuItem(Icons.delete, S.of(context).delete, onDelete, color: Colors.red),
            _menuItem(Icons.delete_forever, S.of(context).delete_for_all, onDeleteForAll,
                color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String text, VoidCallback onTap,
      {Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color ?? Colors.white, size: 22),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                color: color ?? Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WhatsAppMenuOverlay extends StatefulWidget {
  final Offset position;
  final double bubbleWidth;
  final VoidCallback onCopy;
  final VoidCallback onDelete;
  final VoidCallback onDeleteForAll;
  final VoidCallback onDismiss;
  final bool showAbove;

  const WhatsAppMenuOverlay({
    required this.position,
    required this.bubbleWidth,
    required this.onCopy,
    required this.onDelete,
    required this.onDeleteForAll,
    required this.onDismiss,
    required this.showAbove,
    super.key,
  });

  @override
  State<WhatsAppMenuOverlay> createState() => _WhatsAppMenuOverlayState();
}

class _WhatsAppMenuOverlayState extends State<WhatsAppMenuOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double menuWidth = 180;
    const double menuHeight = 150;
    final screenWidth = MediaQuery.of(context).size.width;
    double left = widget.position.dx - (menuWidth / 2);
    left = left.clamp(8.0, screenWidth - menuWidth - 8.0);
    double top = widget.showAbove
        ? widget.position.dy - menuHeight - 8
        : widget.position.dy + 8;
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            behavior: HitTestBehavior.translucent,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.2)),
            ),
          ),
        ),
        Positioned(
          left: left,
          top: top,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: WhatsAppMenu(
                onCopy: widget.onCopy,
                onDelete: widget.onDelete,
                onDeleteForAll: widget.onDeleteForAll,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
