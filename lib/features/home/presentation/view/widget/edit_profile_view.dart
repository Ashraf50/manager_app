import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/home/presentation/view/widget/profile_photo.dart';
import 'package:manager_app/generated/l10n.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_styles.dart';
import '../../../../../core/constant/func/get_token.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../../../../../core/widget/custom_toast.dart';
import '../../../data/model/user_model/user_model.dart';
import '../../view_model/cubit/user_data_cubit.dart';

class EditProfileView extends StatefulWidget {
  final UserModel user;
  const EditProfileView({
    super.key,
    required this.user,
  });

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  final formKey = GlobalKey<FormState>();
  File? avatar;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nameController.text = widget.user.data!.name ?? S.of(context).null_value;
    emailController.text = widget.user.data!.email ?? S.of(context).null_value;
    phoneController.text = widget.user.data!.phone ?? S.of(context).null_value;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: S.of(context).editProfile),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<UserDataCubit, UserDataState>(
          listener: (context, state) async {
            if (state is UpdateUserDataLoading) {
              SmartDialog.showLoading();
            } else if (state is UpdateUserDataSuccess) {
              final token = await getToken();
              context.read<UserDataCubit>().fetchUserData(token!);
              context.go('/manager_home');
              CustomToast.show(
                message: S.of(context).Profile_updated,
                alignment: Alignment.topCenter,
                backgroundColor: AppColors.toastColor,
              );
              SmartDialog.dismiss();
            } else if (state is UpdateUserDataFailure) {
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
                    image: widget.user.data!.avatar!,
                    onImagePicked: (pickedImage) {
                      setState(() {
                        avatar = pickedImage;
                      });
                    },
                  ),
                  Text(
                    S.of(context).name,
                    style: AppStyles.textStyle18bold,
                  ),
                  CustomTextfield(
                    hintText:
                        widget.user.data!.name ?? S.of(context).null_value,
                    controller: nameController,
                    prefixIcon: const Icon(Icons.person),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == '') {
                        return S.of(context).empty_field;
                      } else {
                        return null;
                      }
                    },
                  ),
                  Text(
                    S.of(context).Email,
                    style: AppStyles.textStyle18bold,
                  ),
                  CustomTextfield(
                    hintText:
                        widget.user.data!.email ?? S.of(context).null_value,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email),
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return value != null && !EmailValidator.validate(value)
                          ? S.of(context).enter_valid_email
                          : null;
                    },
                  ),
                  Text(
                    S.of(context).phone,
                    style: AppStyles.textStyle18bold,
                  ),
                  CustomTextfield(
                    hintText:
                        widget.user.data!.phone ?? S.of(context).null_value,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.phone),
                    controller: phoneController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length != 11) {
                        return S.of(context).enter_valid_phone;
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomButton(
                    title: S.of(context).submit,
                    color: nameController.text.isEmpty
                        ? AppColors.inActiveBlue
                        : AppColors.activeBlue,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (avatar == null) {
                          CustomToast.show(
                            message:
                                S.of(context).Please_select_profile_picture,
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
                          message: S.of(context).check_data,
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
