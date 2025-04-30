part of 'user_data_cubit.dart';

sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class GetUserDataLoading extends UserDataState {}

final class GetUserDataSuccess extends UserDataState {
  final UserModel userData;
  GetUserDataSuccess({required this.userData});
}

final class GetUserDataFailure extends UserDataState {
  final String errMessage;
  GetUserDataFailure({required this.errMessage});
}

final class UpdateUserDataLoading extends UserDataState {}

final class UpdateUserDataSuccess extends UserDataState {
  final UserModel userData;
  UpdateUserDataSuccess({required this.userData});
}

final class UpdateUserDataFailure extends UserDataState {
  final String errMessage;
  UpdateUserDataFailure({required this.errMessage});
}
