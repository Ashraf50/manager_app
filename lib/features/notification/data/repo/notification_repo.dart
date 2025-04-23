import 'package:dartz/dartz.dart';
import 'package:manager_app/core/error/failure.dart';
import 'package:manager_app/features/notification/data/model/pagination_response.dart';

abstract class NotificationRepo {
  Future<Either<Failure, PaginatedNotificationResponse>> fetchAllNotifications(
      {int page = 1});
  Future<Either<Failure, Unit>> deleteNotification(String id);
  Future<Either<Failure, Unit>> markNotificationAsRead(String id);
}
