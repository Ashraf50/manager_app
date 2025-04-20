import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_button.dart';
import 'package:manager_app/core/widget/custom_toast.dart';
import 'package:manager_app/features/add_ticketian/presentation/view_model/cubit/add_ticketian_cubit.dart';
import '../../../../../../../core/widget/custom_text_field.dart';
import '../../../../../core/constant/app_styles.dart';
import '../../../../../core/widget/custom_scaffold.dart';

class AddNewTicketian extends StatefulWidget {
  const AddNewTicketian({super.key});

  @override
  State<AddNewTicketian> createState() => _AddNewTicketianState();
}

class _AddNewTicketianState extends State<AddNewTicketian> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController phonePassController = TextEditingController();
  bool visibility = true;
  final formKey = GlobalKey<FormState>();

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
    return BlocListener<AddTicketianCubit, AddTicketianState>(
      listener: (context, state) {
        if (state is FetchAllTicketianLoading) {
          SmartDialog.showLoading();
        } else if (state is FetchAllTicketianFailure) {
          SmartDialog.dismiss();
          CustomToast.show(
            message: state.errMessage,
            backgroundColor: Colors.red,
          );
        } else {
          SmartDialog.dismiss();
          context.pop(context);
          CustomToast.show(
            message: "Manager Created Successfully",
            alignment: Alignment.topCenter,
            backgroundColor: AppColors.toastColor,
          );
        }
      },
      child: CustomScaffold(
        appBar: const CustomAppBar(title: "Create New"),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Name",
                  style: AppStyles.textStyle18bold,
                ),
                CustomTextfield(
                  hintText: "Name",
                  controller: nameController,
                ),
                Text(
                  "Email",
                  style: AppStyles.textStyle18bold,
                ),
                CustomTextfield(
                  hintText: "Email",
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
                  hintText: "Phone",
                  controller: phonePassController,
                ),
                Text(
                  "password",
                  style: AppStyles.textStyle18bold,
                ),
                CustomTextfield(
                  hintText: "password",
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
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.length < 6) {
                      return "your password is too short";
                    } else {
                      return null;
                    }
                  },
                ),
                Text(
                  "confirm password",
                  style: AppStyles.textStyle18bold,
                ),
                CustomTextfield(
                  hintText: "Confirm password",
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
                  controller: confirmPassController,
                ),
                CustomButton(
                  title: "Submit",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      final cubit = context.read<AddTicketianCubit>();
                      await cubit.createTicketian(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phonePassController.text,
                        password: passwordController.text,
                        confirmPass: confirmPassController.text,
                      );
                    } else {
                      CustomToast.show(message: "Check email or password");
                    }
                  },
                  color: nameController.text.isEmpty
                      ? AppColors.inActiveBlue
                      : AppColors.activeBlue,
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
