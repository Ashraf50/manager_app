import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color color;
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Center(
          child: Text(
            title,
            style: AppStyles.textStyle18white,
          ),
        ),
      ),
    );
  }
}
