import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/app_images.dart';
import 'package:manager_app/core/constant/app_styles.dart';

class AddButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Widget? icon;
  const AddButton({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
        decoration: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 10),
            ] else ...[
              SvgPicture.asset(
                Assets.addRecord,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                height: 25,
              ),
              const SizedBox(width: 10),
            ],
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .3,
              child: Text(
                title,
                style: AppStyles.textStyle18white,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
