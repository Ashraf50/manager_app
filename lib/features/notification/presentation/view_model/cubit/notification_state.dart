part of 'notification_cubit.dart';

sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class FetchNotificationLoading extends NotificationState {}

final class FetchNotificationLoadingMore extends NotificationState {}

final class FetchNotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  final bool hasMore;
  FetchNotificationSuccess({
    required this.notifications,
    this.hasMore = false,
  });
}

final class FetchNotificationFailure extends NotificationState {
  final String errMessage;
  FetchNotificationFailure({required this.errMessage});
}
