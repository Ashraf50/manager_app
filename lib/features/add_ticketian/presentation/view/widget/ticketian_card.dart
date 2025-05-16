import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_text_field.dart';
import 'package:manager_app/core/widget/custom_toast.dart';
import 'package:manager_app/features/add_ticketian/data/model/ticketian_model/ticketian_model.dart';
import 'package:manager_app/features/add_ticketian/presentation/view_model/cubit/add_ticketian_cubit.dart';
import 'package:manager_app/generated/l10n.dart';

class TicketianCard extends StatelessWidget {
  final TicketianModel ticketian;
  const TicketianCard({super.key, required this.ticketian});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        ticketian.user!.name!,
                        style: AppStyles.textStyle18black,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .6,
                        child: Text(
                          ticketian.user!.email!,
                          style: AppStyles.textStyle18black,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton(
                color: Colors.white,
                icon: const Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text(S.of(context).edit),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(S.of(context).delete),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                    _showEditDialog(context);
                  } else if (value == 'delete') {
                    _showDeleteDialog(context);
                  }
                },
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final nameController = TextEditingController(text: ticketian.user!.name!);
    final emailController = TextEditingController(text: ticketian.user!.email!);
    final phoneController =
        TextEditingController(text: ticketian.user?.phone ?? "N/A");
    final passwordController = TextEditingController();
    final confirmPassController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocListener<AddTicketianCubit, AddTicketianState>(
        listener: (context, state) {
          if (state is EditTicketianSuccess) {
            Navigator.pop(context);
            CustomToast.show(
              message: S.of(context).Profile_updated,
              backgroundColor: AppColors.toastColor,
            );
          } else if (state is EditTicketianFailure) {
            CustomToast.show(
              message: state.errMessage,
              backgroundColor: Colors.red,
            );
          }
        },
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.of(context).edit_ticketian,
                  style: AppStyles.textStyle18bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  hintText: S.of(context).name,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).name;
                    }
                    return null;
                  },
                ),
                CustomTextfield(
                  hintText: S.of(context).email,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).enter_valid_email;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  hintText: S.of(context).phone,
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).enter_valid_phone;
                    }
                    return null;
                  },
                ),
                CustomTextfield(
                  hintText: S.of(context).password,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pass_short;
                    }
                    return null;
                  },
                ),
                CustomTextfield(
                  hintText: S.of(context).confirmPassword,
                  controller: confirmPassController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).confirmPassword;
                    }
                    if (value != passwordController.text) {
                      return S.of(context).pass_not_match;
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(S.of(context).cancel),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<AddTicketianCubit>().editTicketian(
                                id: ticketian.id!,
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                                confirmPass: confirmPassController.text,
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(S.of(context).save),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    SmartDialog.show(
      builder: (_) => AlertDialog(
        title: Text(S.of(context).confirm_delete),
        content: Text(S.of(context).sure_delete_ticketian),
        actions: [
          TextButton(
            onPressed: () => SmartDialog.dismiss(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<AddTicketianCubit>().deleteTicketian(ticketian.id!);
              SmartDialog.dismiss();
            },
            child: Text(S.of(context).delete,
                style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
