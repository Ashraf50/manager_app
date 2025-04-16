import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_styles.dart';
import '../../../../../core/constant/func/get_token.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../../../../../core/widget/custom_toast.dart';
import '../../view_model/cubit/user_data_cubit.dart';
import '../../../../all_tickets/presentation/view/widget/profile_photo.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? avatar;
    @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: "Edit Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<UserDataCubit, UserDataState>(
          listener: (context, state) async {
            if (state is UserDataLoading) {
              SmartDialog.showLoading();
            } else if (state is UserDataSuccess) {
              final token = await getToken();
              context.read<UserDataCubit>().fetchUserData(token!);
              context.go('/manager_home');
              CustomToast.show(
                message: "Profile updated successfully",
                alignment: Alignment.topCenter,
                backgroundColor: AppColors.toastColor,
              );
              SmartDialog.dismiss();
            } else if (state is UserDataFailure) {
              SmartDialog.dismiss();
              CustomToast.show(
                message: state.errMessage,
                backgroundColor: Colors.red,
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: ListView(
                children: [
                  ProfilePhoto(
                    avatar: avatar,
                    onImagePicked: (pickedImage) {
                      setState(() {
                        avatar = pickedImage;
                      });
                    },
                  ),
                  Text(
                    "Name",
                    style: AppStyles.textStyle18bold,
                  ),
                  CustomTextfield(
                    hintText: "name",
                    controller: nameController,
                    prefixIcon: const Icon(Icons.person),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == '') {
                        return "empty field";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Text(
                    "Email",
                    style: AppStyles.textStyle18bold,
                  ),
                  CustomTextfield(
                    hintText: "email",
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email),
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return value != null && !EmailValidator.validate(value)
                          ? " Enter a valid email"
                          : null;
                    },
                  ),
                  Text(
                    "Phone",
                    style: AppStyles.textStyle18bold,
                  ),
                  CustomTextfield(
                    hintText: "phone",
                    obscureText: false,
                    prefixIcon: const Icon(Icons.phone),
                    controller: phoneController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length != 11) {
                        return "Enter a valid phone num";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomButton(
                    title: "Submit",
                    color: nameController.text.isEmpty
                        ? AppColors.inActiveBlue
                        : AppColors.activeBlue,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (avatar == null) {
                          CustomToast.show(
                            message: "Please select a profile picture",
                            backgroundColor: Colors.red,
                          );
                          return;
                        }
                        context.read<UserDataCubit>().updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              avatar: avatar!,
                            );
                      } else {
                        CustomToast.show(
                          message: "Check your data",
                        );
                      }
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
