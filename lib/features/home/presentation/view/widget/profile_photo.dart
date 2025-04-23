import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_app/features/home/presentation/view/widget/change_phot_button.dart';

class ProfilePhoto extends StatelessWidget {
  final File? avatar;
  final String image;
  final Function(File) onImagePicked;

  const ProfilePhoto({
    super.key,
    required this.avatar,
    required this.onImagePicked,
    required this.image,
  });

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final pickedImage = File(pickedFile.path);
      onImagePicked(pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatar != null
              ? CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(avatar!),
                )
              : CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(image),
                ),
          Positioned(
            bottom: -3,
            right: 11,
            child: ChangePhotoButton(
              choosePhoto: () {
                _pickImage(context, ImageSource.gallery);
                context.pop();
              },
              takePhoto: () {
                _pickImage(context, ImageSource.camera);
                context.pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
