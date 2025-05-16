import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/notification/data/repo/notification_repo_impl.dart';
import 'package:manager_app/features/notification/presentation/view/widget/notification_view_body.dart';
import 'package:manager_app/features/notification/presentation/view_model/cubit/read_notification_cubit.dart';
import '../../../../core/helper/api_helper.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReadNotificationCubit(NotificationRepoImpl(ApiHelper())),
      child: const NotificationViewBody(),
    );
  }
}
