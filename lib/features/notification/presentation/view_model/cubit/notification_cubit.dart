import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/notification/data/model/notification_model/notification_model.dart';
import 'package:manager_app/features/notification/data/repo/notification_repo.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationRepo notificationRepo;
  List<NotificationModel> allNotification = [];
  int currentPage = 1;
  bool hasMore = true;
  bool isFetching = false;
  NotificationCubit(this.notificationRepo) : super(NotificationInitial());
  Future<void> fetchNotifications({bool loadMore = false}) async {
    if (isFetching || (loadMore && !hasMore)) return;
    isFetching = true;
    if (loadMore) {
      emit(FetchNotificationLoadingMore());
    } else {
      currentPage = 1;
      emit(FetchNotificationLoading());
    }
    var result =
        await notificationRepo.fetchAllNotifications(page: currentPage);
    result.fold(
      (failure) {
        isFetching = false;
        emit(FetchNotificationFailure(errMessage: failure.errMessage));
      },
      (response) {
        isFetching = false;
        if (loadMore) {
          allNotification.addAll(response.notifications);
        } else {
          allNotification = response.notifications;
        }
        hasMore = response.currentPage < response.lastPage ||
            response.notifications.length < response.total;
        currentPage = response.currentPage + 1;
        emit(FetchNotificationSuccess(
          notifications: allNotification,
          hasMore: hasMore,
        ));
      },
    );
  }

  Future<void> deleteNotification(String id) async {
    emit(FetchNotificationLoading());
    var result = await notificationRepo.deleteNotification(id);
    result.fold(
      (failure) {
        emit(FetchNotificationFailure(errMessage: failure.errMessage));
      },
      (_) async {
        await fetchNotifications();
      },
    );
  }

  Future<void> readNotification(String id) async {
    emit(FetchNotificationLoading());
    var result = await notificationRepo.markNotificationAsRead(id);
    result.fold(
      (failure) {
        emit(FetchNotificationFailure(errMessage: failure.errMessage));
      },
      (_) async {
        await fetchNotifications();
      },
    );
  }
}
