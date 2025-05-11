import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/core/widget/custom_search.dart';
import 'package:manager_app/features/chat/presentation/view/widget/chats_list_view.dart';
import 'package:manager_app/generated/l10n.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            CustomSearch(
              hintText: S.of(context).search,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              S.of(context).chats,
              style: AppStyles.textStyle18bold,
            ),
            const SizedBox(
              height: 10,
            ),
            const ChatsListView(),
          ],
        ),
      ),
    );
  }
}
