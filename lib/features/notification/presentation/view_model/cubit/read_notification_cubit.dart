import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_app/features/notification/data/repo/notification_repo.dart';
part 'read_notification_state.dart';

class ReadNotificationCubit extends Cubit<ReadNotificationState> {
  NotificationRepo notificationRepo;
  ReadNotificationCubit(this.notificationRepo)
      : super(ReadNotificationInitial());

  Future<void> readNotification(String id) async {
    emit(ReadNotificationLoading());
    final result = await notificationRepo.markNotificationAsRead(id);
    result.fold(
      (failure) => emit(ReadNotificationFailure(failure.errMessage)),
      (_) => emit(ReadNotificationSuccess(notificationId: id)),
    );
  }

  Future<void> deleteNotification(String id) async {
    emit(DeleteNotificationLoading());
    final result = await notificationRepo.deleteNotification(id);
    result.fold(
      (failure) => emit(DeleteNotificationFailure(failure.errMessage)),
      (_) => emit(DeleteNotificationSuccess()),
    );
  }
}
