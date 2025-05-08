import 'package:manager_app/features/dashboard/data/model/statistics/statistics.dart';

abstract class DashboardRepo {
  Future<void> sendFcmToken(String fcmToken);
  Future<StatisticsModel> getStatistics();
}
