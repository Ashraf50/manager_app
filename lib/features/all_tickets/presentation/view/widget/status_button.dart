import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_colors.dart';

class StatusButton extends StatelessWidget {
  final int status;
  const StatusButton({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    Color color;
    Color textColor;
    switch (status) {
      case 0:
        title = "Pending";
        color = AppColors.pendingColors;
        textColor = AppColors.darkGrey;
        break;
      case 1:
        title = "In Progress";
        color = AppColors.processingColors;
        textColor = Colors.orange;
        break;
      case 2:
        title = "Resolved";
        color = AppColors.completedColors;
        textColor = Colors.green;
        break;
      case 3:
        title = "Closed";
        color = AppColors.closeColors!;
        textColor = Colors.white;
        break;
      default:
        title = "Unknown";
        color = AppColors.white;
        textColor = Colors.black;
        break;
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
