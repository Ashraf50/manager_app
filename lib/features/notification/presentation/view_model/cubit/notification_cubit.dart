import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/notification/data/model/notification_model/notification_model.dart';
import 'package:manager_app/features/notification/data/repo/notification_repo.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo notificationRepo;
  List<NotificationModel> allNotification = [];
  int currentPage = 1;
  bool hasMore = true;
  bool isFetching = false;
  NotificationCubit(this.notificationRepo) : super(NotificationInitial());

  Future<void> fetchNotifications({
    bool loadMore = false,
    bool reset = false,
  }) async {
    if (isFetching) return;
    if (!hasMore && loadMore) return;
    isFetching = true;
    try {
      if (reset) {
        currentPage = 1;
        hasMore = true;
        allNotification.clear();
        emit(FetchNotificationLoading());
      } else if (!loadMore) {
        emit(FetchNotificationLoading());
      }
      final fetchedNotifications = await notificationRepo.fetchAllNotifications(
        page: currentPage,
      );
      if (fetchedNotifications.isEmpty) {
        hasMore = false;
        if (currentPage == 1) {
          emit(FetchNotificationEmpty());
        } else {
          emit(
            FetchNotificationSuccess(
              notifications: List.from(allNotification),
              hasMore: false,
            ),
          );
        }
      } else {
        allNotification.addAll(fetchedNotifications);
        currentPage++;
        emit(FetchNotificationSuccess(
          notifications: List.from(allNotification),
          hasMore: true,
        ));
      }
    } catch (e) {
      emit(FetchNotificationFailure(
        errMessage: "Failed to load notifications",
        currentNotifications: loadMore ? List.from(allNotification) : null,
      ));
    } finally {
      isFetching = false;
    }
  }

  void loadMoreNotifications() {
    if (!isFetching && hasMore) {
      fetchNotifications(loadMore: true);
    }
  }
}
