import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_button.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/core/widget/custom_text_field.dart';
import 'package:manager_app/features/Auth/presentation/view_model/bloc/auth_bloc.dart';
import 'package:manager_app/generated/l10n.dart';
import '../../../../../core/widget/custom_toast.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgetLoading) {
          SmartDialog.showLoading();
        } else if (state is ForgetSuccess) {
          context.go('/reset_pass');
          CustomToast.show(
            message: state.successMessage,
            alignment: Alignment.topCenter,
            backgroundColor: AppColors.toastColor,
          );
          SmartDialog.dismiss();
        } else if (state is ForgetFailure) {
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
                      S.of(context).reset_pass,
                      style: AppStyles.textStyle20blackBold.copyWith(height: 2),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${S.of(context).reset_desc1}\n${S.of(context).reset_desc2}",
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
                  SizedBox(height: 15.h),
                  CustomButton(
                    title: S.of(context).forget_password,
                    color: emailController.text.isEmpty
                        ? AppColors.inActiveBlue
                        : AppColors.activeBlue,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(ForgetPassEvent(
                          email: emailController.text,
                        ));
                      } else {
                        CustomToast.show(
                          message: S.of(context).check_email_only,
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
