part of 'notification_cubit.dart';

sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class FetchNotificationLoading extends NotificationState {}

final class FetchNotificationEmpty extends NotificationState {}

final class FetchNotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  final bool hasMore;
  FetchNotificationSuccess({
    required this.notifications,
    required this.hasMore,
  });
}

final class FetchNotificationFailure extends NotificationState {
  final String errMessage;
  final List<NotificationModel>? currentNotifications;

  FetchNotificationFailure({
    required this.errMessage,
    this.currentNotifications,
  });
}
