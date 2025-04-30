import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import '../../../../../core/constant/app_colors.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final String iconAsset;
  final Color circleColor;
  const CustomCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.iconAsset,
    required this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.all(8.w),
      constraints: BoxConstraints(
        maxWidth: 200.w,
        minWidth: 150.w,
        minHeight: 180.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(13.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: const Color(0xff9198B3).withOpacity(0.3),
                width: 5.w,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: circleColor,
                  width: 5.w,
                ),
              ),
              child: Center(
                child: Text(
                  percentage,
                  style: AppStyles.textStyle18bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: AppStyles.textStyle16Black,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 8.w),
              SvgPicture.asset(
                iconAsset,
                height: 20.h,
                color: AppColors.buttonDrawer,
              )
            ],
          ),
          Text(
            value,
            style: AppStyles.textStyle18bold,
          )
        ],
      ),
    );
  }
}
