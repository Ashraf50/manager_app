import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_text_field.dart';
import 'package:manager_app/generated/l10n.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_scaffold.dart';
import '../../../../../core/widget/custom_toast.dart';
import '../../view_model/bloc/auth_bloc.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool visibility = true;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetLoading) {
          SmartDialog.showLoading();
        } else if (state is ResetSuccess) {
          context.go('/sign_in');
          CustomToast.show(
            message: state.successMessage,
            alignment: Alignment.topCenter,
            backgroundColor: AppColors.toastColor,
          );
          SmartDialog.dismiss();
        } else if (state is ResetFailure) {
          SmartDialog.dismiss();
          CustomToast.show(
            message: state.errMessage,
            backgroundColor: Colors.red,
          );
        } else if (state is VerifyCodeLoading) {
          SmartDialog.showLoading(msg: "Verifying...");
        } else if (state is VerifyCodeSuccess) {
          SmartDialog.dismiss();
          BlocProvider.of<AuthBloc>(context).add(
            ResetPassEvent(
              email: emailController.text,
              code: codeController.text,
              password: passwordController.text,
              passwordConfirm: confirmPasswordController.text,
            ),
          );
        } else if (state is VerifyCodeFailure) {
          SmartDialog.dismiss();
          CustomToast.show(
            message: state.errMessage,
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      S.of(context).create_new_pass,
                      style: AppStyles.textStyle20blackBold.copyWith(height: 2),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${S.of(context).create_pass1}\n ${S.of(context).create_pass2}",
                      style: AppStyles.textStyle18black,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    S.of(context).Email,
                    style: AppStyles.textStyle18black,
                  ),
                  CustomTextfield(
                    hintText: S.of(context).email,
                    obscureText: false,
                    controller: emailController,
                    prefixIcon: const Icon(Icons.email),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return value != null && !EmailValidator.validate(value)
                          ? S.of(context).enter_valid_email
                          : null;
                    },
                  ),
                  Text(
                    S.of(context).code,
                    style: AppStyles.textStyle18black,
                  ),
                  CustomTextfield(
                    hintText: S.of(context).enter_code,
                    obscureText: false,
                    controller: codeController,
                    prefixIcon: const Icon(Icons.code),
                  ),
                  Text(
                    S.of(context).Password,
                    style: AppStyles.textStyle18black,
                  ),
                  CustomTextfield(
                    hintText: S.of(context).password,
                    obscureText: visibility,
                    prefixIcon: const Icon(Icons.lock_sharp),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visibility = !visibility;
                        });
                      },
                      icon: visibility
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                    ),
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length < 6) {
                        return S.of(context).pass_short;
                      } else {
                        return null;
                      }
                    },
                  ),
                  Text(
                    S.of(context).confirmPassword,
                    style: AppStyles.textStyle18black,
                  ),
                  CustomTextfield(
                    hintText: S.of(context).confirmPassword,
                    prefixIcon: const Icon(Icons.lock_sharp),
                    obscureText: visibility,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visibility = !visibility;
                        });
                      },
                      icon: visibility
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                    ),
                    controller: confirmPasswordController,
                  ),
                  CustomButton(
                    title: S.of(context).reset_pass,
                    color: passwordController.text.isEmpty
                        ? AppColors.inActiveBlue
                        : AppColors.activeBlue,
                    onTap: () {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            VerifyCodeEvent(
                              email: emailController.text,
                              code: codeController.text,
                            ),
                          );
                        } else {
                          CustomToast.show(
                            message: S.of(context).check_email,
                          );
                        }
                      } else {
                        CustomToast.show(
                          message: S.of(context).pass_not_match,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
