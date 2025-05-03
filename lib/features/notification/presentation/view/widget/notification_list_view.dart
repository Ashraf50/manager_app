import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/features/notification/presentation/view/widget/notification_card.dart';
import 'package:manager_app/features/notification/presentation/view_model/cubit/notification_cubit.dart';
import '../../view_model/cubit/read_notification_cubit.dart';

class AllNotificationsListView extends StatefulWidget {
  const AllNotificationsListView({super.key});

  @override
  State<AllNotificationsListView> createState() =>
      _AllNotificationsListViewState();
}

class _AllNotificationsListViewState extends State<AllNotificationsListView> {
  late ScrollController _scrollController;
  late NotificationCubit notificationCubit;
  @override
  void initState() {
    super.initState();
    notificationCubit = context.read<NotificationCubit>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      notificationCubit.loadMoreNotifications();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.95);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is FetchNotificationSuccess) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              var notifications = state.notifications;
              return InkWell(
                onTap: () {
                  context.push(
                    "/notification_details",
                    extra: notifications[index],
                  );
                  if (notifications[index].seen == false) {
                    context
                        .read<ReadNotificationCubit>()
                        .readNotification(notifications[index].id!);
                  }
                },
                child: NotificationCard(
                  notification: notifications[index],
                  notificationColor: notifications[index].seen!
                      ? Colors.white
                      : const Color.fromARGB(99, 210, 207, 207),
                ),
              );
            },
          );
        } else if (state is FetchNotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchNotificationFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
