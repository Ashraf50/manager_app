import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/features/chat/presentation/view/widget/chat_card.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            context.push('/chat_details');
          },
          child: const ChatCard(),
        );
      },
    );
  }
}
