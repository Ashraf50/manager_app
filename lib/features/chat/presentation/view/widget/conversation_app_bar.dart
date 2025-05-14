import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConversationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String userName;
  final String userImageUrl;
  const ConversationAppBar({
    super.key,
    required this.userName,
    required this.userImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          InkWell(
            onTap: () {
              context.push('/photo_view', extra: userImageUrl);
            },
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(userImageUrl),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
