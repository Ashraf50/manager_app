import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/func/data_format.dart';
import 'package:manager_app/features/chat/data/model/message_model/message_model.dart';

class ChatBubbleFriend extends StatelessWidget {
  final MessageModel message;
  const ChatBubbleFriend({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.content != null && message.content!.isNotEmpty)
                  Text(
                    message.content!,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                if (message.media != null && message.media!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        onTap: () {
                          context.push('/photo_view', extra: message.media);
                        },
                        child: Image.network(
                          message.media!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              dateTimeFormat(
                message.createdAt.toString(),
                'hh:mm a',
              ),
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: AppColors.buttonDrawer,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (message.content != null && message.content!.isNotEmpty)
                  Text(
                    message.content!,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                if (message.media != null && message.media!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        onTap: () {
                          context.push('/photo_view', extra: message.media);
                        },
                        child: Image.network(
                          message.media!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              dateTimeFormat(
                message.createdAt!.toString(),
                'hh:mm a',
              ),
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
