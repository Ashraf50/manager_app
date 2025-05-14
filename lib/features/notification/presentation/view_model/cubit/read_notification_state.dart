part of 'read_notification_cubit.dart';

sealed class ReadNotificationState {}

final class ReadNotificationInitial extends ReadNotificationState {}

class ReadNotificationLoading extends ReadNotificationState {}

class ReadNotificationSuccess extends ReadNotificationState {
    final String notificationId;
      ReadNotificationSuccess({required this.notificationId});
}

class ReadNotificationFailure extends ReadNotificationState {
  final String errMessage;
  ReadNotificationFailure(this.errMessage);
}

class DeleteNotificationLoading extends ReadNotificationState {}

class DeleteNotificationSuccess extends ReadNotificationState {}

class DeleteNotificationFailure extends ReadNotificationState {
  final String errMessage;
  DeleteNotificationFailure(this.errMessage);
}
