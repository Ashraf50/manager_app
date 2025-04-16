import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_button.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/core/widget/custom_text_field.dart';
import 'package:manager_app/features/Auth/presentation/view/widget/custom_auth_app_bar.dart';

import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/widget/custom_toast.dart';
import '../../../../home/presentation/view_model/cubit/user_data_cubit.dart';
import '../../view_model/bloc/auth_bloc.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool visibility = true;
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
        if (state is LoginLoading) {
          SmartDialog.showLoading();
        } else if (state is LoginSuccess) {
          context.read<UserDataCubit>().fetchUserData(state.token);
          context.go('/manager_home');
          CustomToast.show(
            message: state.successMessage,
            alignment: Alignment.topCenter,
            backgroundColor: AppColors.toastColor,
          );
          SmartDialog.dismiss();
        } else if (state is LoginFailure) {
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
            child: ListView(
              children: [
                const CustomAuthAppBar(
                  title: 'Welcome Back!',
                  subTitle:
                      'To keep connected with us please\nlogin with your personal Info',
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Sign In',
                  style: AppStyles.textStyle20blackBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: AppStyles.textStyle18black,
                      ),
                      CustomTextfield(
                        hintText: "Enter your email",
                        obscureText: false,
                        prefixIcon: const Icon(Icons.email),
                        controller: emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value != null &&
                                  !EmailValidator.validate(value)
                              ? " Enter a valid email"
                              : null;
                        },
                      ),
                      Text(
                        "Password",
                        style: AppStyles.textStyle18black,
                      ),
                      CustomTextfield(
                        hintText: "Enter your password",
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              context.push('/forget_pass');
                            },
                            child: Text(
                              'forget password!',
                              style: AppStyles.textStyle18blue,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15.h),
                      CustomButton(
                        title: "Sign In",
                        color: emailController.text.isEmpty
                            ? AppColors.inActiveBlue
                            : AppColors.activeBlue,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ));
                          } else {
                            CustomToast.show(
                              message: "check the email or password",
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
