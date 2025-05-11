import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/constant/func/data_format.dart';
import 'package:manager_app/features/notification/data/model/notification_model/notification_model.dart';
import 'package:manager_app/features/notification/presentation/view_model/cubit/read_notification_cubit.dart';
import 'package:manager_app/generated/l10n.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final Color notificationColor;
  const NotificationCard({
    super.key,
    required this.notification,
    required this.notificationColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: notificationColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        notification.title!,
                        style: AppStyles.textStyle16Black,
                        softWrap: true,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        notification.body!,
                        style: AppStyles.textStyle16,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      "${dateTimeFormat(notification.createdAt.toString(), 'h')} ${S.of(context).hour}",
                      style: AppStyles.textStyle16,
                      softWrap: true,
                    ),
                  ],
                ),
                PopupMenuButton(
                  color: Colors.white,
                  icon: const Icon(Icons.more_horiz),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'read',
                      child: Text(S.of(context).read),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(S.of(context).delete),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'read') {
                      context
                          .read<ReadNotificationCubit>()
                          .readNotification(notification.id!);
                    } else if (value == 'delete') {
                      _showFinishDialog(context);
                    }
                  },
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _showFinishDialog(BuildContext context) {
    SmartDialog.show(
      builder: (_) => AlertDialog(
        title: Text(S.of(context).confirm_delete),
        content: Text(S.of(context).sure_delete_notification),
        actions: [
          TextButton(
            onPressed: () => SmartDialog.dismiss(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<ReadNotificationCubit>()
                  .deleteNotification(notification.id!);
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
