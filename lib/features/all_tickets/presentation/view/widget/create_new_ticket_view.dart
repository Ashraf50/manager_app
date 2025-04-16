import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/core/widget/custom_text_field.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/formatting_text_fiel.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/drop_down_text_field.dart';

class CreateNewTicketView extends StatelessWidget {
  const CreateNewTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: "Create New"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "First Name",
              style: AppStyles.textStyle18bold,
            ),
            CustomTextfield(
              hintText: "First Name",
              controller: TextEditingController(),
            ),
            Text(
              "Last Name",
              style: AppStyles.textStyle18bold,
            ),
            CustomTextfield(
              hintText: "Last Name",
              controller: TextEditingController(),
            ),
            Text(
              "Email",
              style: AppStyles.textStyle18bold,
            ),
            CustomTextfield(
              hintText: "Email",
              controller: TextEditingController(),
            ),
            Text(
              'Department',
              style: AppStyles.textStyle18bold,
            ),
            const DropdownTextField(),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Text',
              style: AppStyles.textStyle18bold,
            ),
            const FormattingTextField(),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              title: "Submit",
              color: AppColors.inActiveBlue,
              onTap: () {},
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
