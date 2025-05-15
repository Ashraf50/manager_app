import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomCardShimmer extends StatelessWidget {
  const CustomCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.all(8.w),
      constraints: BoxConstraints(
        maxWidth: 200.w,
        minWidth: 150.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(13.r),
        color: Colors.white,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70.w,
              height: 70.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: 100.w,
              height: 16.h,
              color: Colors.white,
            ),
            Container(
              width: 60.w,
              height: 20.h,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
