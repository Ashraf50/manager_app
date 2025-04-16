import 'package:flutter/material.dart';
import '../../../../../core/constant/app_colors.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.processingColors,
          borderRadius: BorderRadius.circular(12)),
      child: const Text(
        "Processing",
        style: TextStyle(
          color: Color(0xffFF9F43),
          fontSize: 16,
        ),
      ),
    );
  }
}
