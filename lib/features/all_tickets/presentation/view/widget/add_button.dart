import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import '../../../../../core/constant/app_images.dart';

class AddButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const AddButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
        decoration: BoxDecoration(
            color: AppColors.darkBlue, borderRadius: BorderRadius.circular(13)),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.addRecord,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              height: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: AppStyles.textStyle18white,
            )
          ],
        ),
      ),
    );
  }
}
