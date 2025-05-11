import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/generated/l10n.dart';

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
        title = S.of(context).pending;
        color = AppColors.pendingColors;
        textColor = AppColors.darkGrey;
        break;
      case 1:
        title = S.of(context).inProgress;
        color = AppColors.processingColors;
        textColor = Colors.orange;
        break;
      case 2:
        title = S.of(context).resolved;
        color = AppColors.completedColors;
        textColor = Colors.green;
        break;
      case 3:
        title = S.of(context).closed;
        color = AppColors.closeColors!;
        textColor = Colors.white;
        break;
      default:
        title = S.of(context).unKnown;
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
