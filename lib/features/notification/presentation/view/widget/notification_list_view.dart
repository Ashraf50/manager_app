import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/widget/custom_toast.dart';
import 'package:manager_app/features/all_tickets/presentation/view_model/cubit/ticket_cubit.dart';
import 'package:manager_app/features/notification/presentation/view/widget/notification_card.dart';
import 'package:manager_app/features/notification/presentation/view/widget/notification_shimmer.dart';
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
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500 + (index * 100)),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: InkWell(
                  onTap: () async {
                    final notification = notifications[index];
                    if (notification.seen == false) {
                      context
                          .read<ReadNotificationCubit>()
                          .readNotification(notification.id!);
                    }
                    final data = notification.data?.toJson();
                    if (data != null &&
                        (data['type'] == 'ticket_created' ||
                            data['type'] == 'ticket_updated' ||
                            data['type'] == 'ticket_assigned' ||
                            data['type'] == 'ticket_resolved')) {
                      try {
                        final modelId = data['model_id'];
                        if (modelId != null) {
                          final ticketCubit = context.read<TicketCubit>();
                          final result = await ticketCubit
                              .getTicketById(int.parse(modelId.toString()));
                          result.fold(
                            (failure) {
                              CustomToast.show(
                                message: failure.errMessage,
                                backgroundColor: Colors.red,
                              );
                            },
                            (ticket) {
                              context.push('/ticket_details', extra: ticket);
                            },
                          );
                        }
                      } catch (e) {
                        print('Error handling ticket notification: $e');
                      }
                    }
                  },
                  child: NotificationCard(
                    notification: notifications[index],
                    notificationColor: notifications[index].seen!
                        ? Colors.white
                        : const Color.fromARGB(99, 210, 207, 207),
                  ),
                ),
              );
            },
          );
        } else if (state is FetchNotificationLoading) {
          return const NotificationShimmer();
        } else if (state is FetchNotificationFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errMessage),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => notificationCubit.fetchNotifications(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
