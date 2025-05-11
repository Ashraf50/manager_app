import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/helper/api_helper.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/notification/data/repo/notification_repo_impl.dart';
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
      appBar: CustomAppBar(title: S.of(context).notification),
      body: BlocProvider(
        create: (context) =>
            ReadNotificationCubit(NotificationRepoImpl(ApiHelper())),
        child: BlocListener<ReadNotificationCubit, ReadNotificationState>(
          listener: (context, state) {
            if (state is DeleteNotificationFailure ||
                state is ReadNotificationFailure) {
              CustomToast.show(
                message: (state as dynamic).errMessage,
                backgroundColor: Colors.red,
              );
            }
            if (state is DeleteNotificationSuccess ||
                state is ReadNotificationSuccess) {
              context.read<NotificationCubit>().fetchNotifications(reset: true);
              CustomToast.show(
                message: S.of(context).notification_deleted_successfully,
                backgroundColor: AppColors.toastColor,
              );
            }
          },
          child: const AllNotificationsListView(),
        ),
      ),
    );
  }
}
