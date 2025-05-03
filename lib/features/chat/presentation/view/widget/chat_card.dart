import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_styles.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/img/profile.jpg",
                ),
                radius: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alaa Elhawary",
                    style: AppStyles.textStyle18black,
                  ),
                  Text(
                    "how are you",
                    style: AppStyles.textStyle16,
                  ),
                ],
              ),
            ],
          ),
          Text(
            "5 m",
            style: AppStyles.textStyle16,
          )
        ],
      ),
    );
  }
}
