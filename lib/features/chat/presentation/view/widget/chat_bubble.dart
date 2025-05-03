import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/func/data_format.dart';

class ChatBubbleFriend extends StatelessWidget {
  const ChatBubbleFriend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: const Text(
              "massage.message!",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              dateTimeFormat(
                "2025-04-28T21:23:15.000000Z",
                'hh:mm a',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: AppColors.buttonDrawer,
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            child: const Text(
              "message",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              dateTimeFormat(
                "2025-04-28T21:23:15.000000Z",
                'hh:mm a',
              ),
            ),
          )
        ],
      ),
    );
  }
}
