import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/notification/presentation/view/widget/notification_list_view.dart';
import 'package:manager_app/features/notification/presentation/view_model/cubit/read_notification_cubit.dart';
import 'package:manager_app/generated/l10n.dart';
import '../../../../../core/widget/custom_toast.dart';
import '../../view_model/cubit/notification_cubit.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: S.of(context).notification,
        actions: [
          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is FetchNotificationSuccess &&
                  state.notifications.isNotEmpty) {
                final unreadCount =
                    state.notifications.where((n) => n.seen == false).length;
                return PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  offset: const Offset(0, 16),
                  color: Colors.white,
                  itemBuilder: (context) => [
                    if (unreadCount > 0)
                      PopupMenuItem(
                        value: 'read_all',
                        child: Row(
                          children: [
                            const Icon(Icons.mark_email_read_outlined,
                                color: Colors.blue),
                            const SizedBox(width: 8),
                            Text(
                              S.of(context).read_all,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    PopupMenuItem(
                      value: 'delete_all',
                      child: Row(
                        children: [
                          const Icon(Icons.delete_sweep_outlined,
                              color: Colors.red),
                          const SizedBox(width: 8),
                          Text(S.of(context).delete_all,
                              style: const TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'read_all') {
                      context
                          .read<ReadNotificationCubit>()
                          .readAllNotifications();
                    } else if (value == 'delete_all') {
                      context
                          .read<ReadNotificationCubit>()
                          .deleteAllNotifications();
                    }
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocListener<ReadNotificationCubit, ReadNotificationState>(
        listener: (context, state) {
          if (state is DeleteNotificationFailure ||
              state is ReadNotificationFailure) {
            CustomToast.show(
              message: (state as dynamic).errMessage,
              backgroundColor: Colors.red,
            );
          }
          if (state is DeleteNotificationSuccess) {
            context.read<NotificationCubit>().fetchNotifications(reset: true);
            CustomToast.show(
              message: S.of(context).notification_deleted_successfully,
              backgroundColor: AppColors.toastColor,
            );
          }
          if (state is ReadNotificationSuccess) {
            context.read<NotificationCubit>().fetchNotifications(reset: true);
            CustomToast.show(
              message: S.of(context).notification_marked_as_read,
              backgroundColor: AppColors.toastColor,
            );
          }
        },
        child: const AllNotificationsListView(),
      ),
    );
  }
}
