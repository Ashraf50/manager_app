import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import '../../../../../core/constant/app_colors.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final String value;
  final String percentage;
  final String iconAsset;
  final Color circleColor;
  final double progress;
  const CustomCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.iconAsset,
    required this.circleColor,
    required this.progress,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _progressAnimation =
        Tween<double>(begin: 0.0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CustomCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _progressAnimation =
          Tween<double>(begin: _progressAnimation.value, end: widget.progress)
              .animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
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
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(_isHovered ? 0.2 : 0.1),
                  spreadRadius: _isHovered ? 3 : 2,
                  blurRadius: _isHovered ? 8 : 5,
                  offset: Offset(0, _isHovered ? 5 : 3),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        final percent =
                            (_progressAnimation.value * 100).round();
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 70.r,
                              height: 70.r,
                              child: CircularProgressIndicator(
                                value: _progressAnimation.value,
                                strokeWidth: 5.r,
                                backgroundColor:
                                    const Color(0xff9198B3).withOpacity(0.3),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    widget.circleColor),
                              ),
                            ),
                            Text(
                              "$percent%",
                              style: AppStyles.textStyle18bold,
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            widget.title,
                            style: AppStyles.textStyle16Black,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SvgPicture.asset(
                          widget.iconAsset,
                          height: 20.h,
                          color: AppColors.buttonDrawer,
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Flexible(
                      child: Text(
                        widget.value,
                        style: AppStyles.textStyle18bold,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
