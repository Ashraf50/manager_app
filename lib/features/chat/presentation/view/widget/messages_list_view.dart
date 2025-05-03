import 'package:flutter/material.dart';
import 'package:manager_app/features/chat/presentation/view/widget/chat_bubble.dart';

class MessagesListView extends StatefulWidget {
  const MessagesListView({super.key});

  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {}
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.95);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        reverse: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onLongPress: () {
              // _showMessageOptions(context, message.id!, message.message!);
            },
            child: const ChatBubbleFriend(),
          );
        });
  }
}

// void _showMessageOptions(BuildContext context, String messageId, String text) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         padding: const EdgeInsets.all(16),
//         child: Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.copy),
//               title: const Text("copy message"),
//               onTap: () {
//                 Clipboard.setData(ClipboardData(text: text));
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.delete, color: Colors.red),
//               title: const Text("delete message"),
//               onTap: () {},
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
