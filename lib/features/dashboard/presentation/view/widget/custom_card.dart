import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_images.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: const Color(0xff9198B3),
                width: 5.w,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.buttonDrawer,
                  width: 5.w,
                ),
              ),
              child: Center(
                child: Text(
                  "100%",
                  style: AppStyles.textStyle18bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Text(
                "All Tickets",
                style: AppStyles.textStyle18black,
              ),
              SizedBox(
                width: 10.w,
              ),
              SvgPicture.asset(
                Assets.ticket,
                height: 28.h,
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "10",
              style: AppStyles.textStyle18bold,
            ),
          )
        ],
      ),
    );
  }
}
