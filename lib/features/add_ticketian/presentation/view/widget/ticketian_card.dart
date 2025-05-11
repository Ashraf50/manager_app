import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_text_field.dart';
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
    final passwordController = TextEditingController(text: "***********");
    final confirmPassController = TextEditingController(text: "**********");
    SmartDialog.show(
      builder: (_) => AlertDialog(
        title: Text(S.of(context).edit_ticketian),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextfield(
              hintText: S.of(context).name,
              controller: nameController,
            ),
            CustomTextfield(
              hintText: S.of(context).email,
              controller: emailController,
            ),
            CustomTextfield(
              hintText: S.of(context).phone,
              controller: phoneController,
            ),
            CustomTextfield(
              hintText: S.of(context).password,
              controller: passwordController,
            ),
            CustomTextfield(
              hintText: S.of(context).confirmPassword,
              controller: confirmPassController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => SmartDialog.dismiss(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<AddTicketianCubit>().editTicketian(
                    id: ticketian.id!,
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    password: passwordController.text,
                    confirmPass: confirmPassController.text,
                  );
              SmartDialog.dismiss();
            },
            child: Text(S.of(context).save),
          ),
        ],
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
