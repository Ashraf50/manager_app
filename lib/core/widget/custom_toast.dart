import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:manager_app/core/constant/app_colors.dart';

class CustomToast {
  static void show({
    required String message,
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.bottomCenter,
    Color backgroundColor = AppColors.darkBlue,
    Color textColor = Colors.white,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SmartDialog.showToast(
        '',
        displayTime: duration,
        alignment: alignment,
        builder: (context) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50, top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    });
  }
}
