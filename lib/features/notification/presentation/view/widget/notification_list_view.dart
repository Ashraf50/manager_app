import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/notification/presentation/view/widget/notification_card.dart';
import 'package:manager_app/features/notification/presentation/view_model/cubit/notification_cubit.dart';

class AllNotificationsListView extends StatefulWidget {
  const AllNotificationsListView({super.key});

  @override
  State<AllNotificationsListView> createState() =>
      _AllNotificationsListViewState();
}

class _AllNotificationsListViewState extends State<AllNotificationsListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<NotificationCubit>().fetchNotifications();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    print(
        "Scrolling... Position: ${_scrollController.position.pixels}, Max: ${_scrollController.position.maxScrollExtent}");
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 10 &&
        !context.read<NotificationCubit>().isFetching &&
        context.read<NotificationCubit>().hasMore) {
      print("Fetching more tickets...");
      context.read<NotificationCubit>().fetchNotifications(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is FetchNotificationSuccess) {
          print(
              "notification count: ${state.notifications.length}, hasMore: ${state.hasMore}");
          return ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.notifications.length + (state.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.notifications.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return InkWell(
                onTap: () {
                  // context.push(
                  //   "/ticket_details",
                  //   extra: state.notifications[index],
                  // );
                },
                child: NotificationCard(
                  notification: state.notifications[index],
                  notificationColor: state.notifications[index].seen!
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
