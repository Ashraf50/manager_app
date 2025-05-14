import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manager_app/core/constant/app_images.dart';
import 'package:manager_app/core/constant/app_styles.dart';

class CustomChatButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color color;
  const CustomChatButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  Assets.chat,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  title,
                  style: AppStyles.textStyle18white,
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
