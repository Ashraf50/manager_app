import 'package:dio/dio.dart';
import 'package:manager_app/core/constant/app_strings.dart';
import 'package:manager_app/core/helper/api_helper.dart';
import 'package:manager_app/features/dashboard/data/model/statistics/statistics.dart';
import 'package:manager_app/features/dashboard/data/repo/dashboard_repo.dart';

class DashboardRepoImpl implements DashboardRepo {
  final ApiHelper apiHelper = ApiHelper();

  DashboardRepoImpl(ApiHelper apiHelper);
  @override
  Future<void> sendFcmToken(String token) async {
    try {
      await apiHelper.patch(
        '${AppStrings.baseUrl}/notifications/fcm_token',
        data: {"fcm_token": token},
      );
      print('✅ FCM Token sent successfully');
    } catch (e) {
      print('❌ Failed to send FCM Token: $e');
      rethrow;
    }
  }

  @override
  Future<StatisticsModel> getStatistics() async {
    try {
      final response =
          await apiHelper.get('${AppStrings.baseUrl}/api/managers/statistics');
      return StatisticsModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Unexpected error occurred';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
