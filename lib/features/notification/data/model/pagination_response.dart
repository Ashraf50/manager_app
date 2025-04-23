import 'package:manager_app/features/notification/data/model/notification_model/notification_model.dart';

class PaginatedNotificationResponse {
  final List<NotificationModel> notifications;
  final int currentPage;
  final int lastPage;
  final int total;

  PaginatedNotificationResponse({
    required this.notifications,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });
}
