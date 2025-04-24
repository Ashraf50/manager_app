import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:manager_app/core/constant/app_strings.dart';
import 'package:manager_app/core/constant/func/get_token.dart';
import 'package:manager_app/core/error/failure.dart';
import 'package:manager_app/core/helper/api_helper.dart';
import 'package:manager_app/features/notification/data/model/notification_model/notification_model.dart';
import 'package:manager_app/features/notification/data/repo/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  ApiHelper apiHelper;
  NotificationRepoImpl(this.apiHelper);
  @override
  Future<List<NotificationModel>> fetchAllNotifications({int page = 1}) async {
    try {
      final token = await getToken();
      var response = await apiHelper.get(
        '${AppStrings.baseUrl}/notifications?per_page=10',
        headers: {
          'Authorization': 'Bearer $token',
        },
        queryParameters: {'page': page},
      );
      var data = response.data;
      var notificationList = (data["data"] as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList();
      return notificationList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNotification(String id) async {
    try {
      final token = await getToken();
      await apiHelper.delete(
        '${AppStrings.baseUrl}/notifications/$id',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return const Right(unit);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> markNotificationAsRead(String id) async {
    try {
      final token = await getToken();
      await apiHelper.patch(
        '${AppStrings.baseUrl}/notifications/$id',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return const Right(unit);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
