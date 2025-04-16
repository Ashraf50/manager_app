import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import '../../../../../core/constant/app_styles.dart';

class CustomAuthAppBar extends StatelessWidget {
  final String title;
  final String subTitle;
  const CustomAuthAppBar({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          Text(
            title,
            style: AppStyles.textStyle24white,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            subTitle,
            style: AppStyles.textStyle16White,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}
