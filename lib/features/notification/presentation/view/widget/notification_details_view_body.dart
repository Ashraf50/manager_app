import 'package:flutter/material.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import '../../../../../core/constant/func/data_format.dart';
import '../../../data/model/notification_model/notification_model.dart';

class NotificationDetailsViewBody extends StatelessWidget {
  final NotificationModel notification;
  const NotificationDetailsViewBody({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: notification.title!),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Text(
              notification.body!,
              style: AppStyles.textStyle18black,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${dateTimeFormat(notification.createdAt.toString(), 'h : mm ')} hours ago",
                  style: AppStyles.textStyle16,
                  softWrap: true,
                ),
                Text(
                  dateTimeFormat(notification.createdAt.toString(), 'dd/M/y '),
                  style: AppStyles.textStyle16,
                  softWrap: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
