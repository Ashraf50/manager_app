import 'package:manager_app/core/constant/app_colors.dart';
import '../../../../../core/constant/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ChangePhotoButton extends StatelessWidget {
  final void Function()? choosePhoto;
  final void Function()? takePhoto;
  const ChangePhotoButton({
    super.key,
    required this.choosePhoto,
    required this.takePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 155,
                child: Column(
                  children: [
                    TextButton(
                      title: "Choose Photo",
                      onTap: choosePhoto,
                    ),
                    const CustomDivider(),
                    TextButton(
                      title: "Take Photo",
                      onTap: takePhoto,
                    ),
                    const CustomDivider(),
                    TextButton(
                      title: "Cancel",
                      onTap: () {
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: CircleAvatar(
        backgroundColor: AppColors.buttonDrawer,
        child: SvgPicture.asset(
          'assets/img/camera.svg',
          height: 23,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(color: Colors.grey),
    );
  }
}

class TextButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const TextButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Center(
          child: Text(
            title,
            style: AppStyles.textStyle18black,
          ),
        ),
      ),
    );
  }
}
