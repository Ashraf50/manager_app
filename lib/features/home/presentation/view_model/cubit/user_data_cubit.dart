import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/user_model/user_model.dart';
import '../../../data/repo/user_repo.dart';
part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final UserRepo userRepo;
  UserDataCubit(this.userRepo) : super(UserDataInitial());

  Future<void> fetchUserData(String token) async {
    emit(GetUserDataLoading());
    final result = await userRepo.fetchUserData(token: token);
    result.fold(
      (failure) {
        emit(
          GetUserDataFailure(errMessage: failure.errMessage),
        );
      },
      (data) {
        emit(
          GetUserDataSuccess(userData: data),
        );
      },
    );
  }

  Future<void> updateUserData({
    required String name,
    required String email,
    required String phone,
    required File avatar,
  }) async {
    emit(UpdateUserDataLoading());
    final result = await userRepo.updateData(
      name: name,
      email: email,
      phone: phone,
      avatar: avatar,
    );
    result.fold(
      (failure) {
        emit(UpdateUserDataFailure(errMessage: failure.errMessage));
      },
      (data) {
        emit(UpdateUserDataSuccess(userData: data));
      },
    );
  }
}
