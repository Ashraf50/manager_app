part of 'user_data_cubit.dart';

sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class UserDataLoading extends UserDataState {}

final class UserDataSuccess extends UserDataState {
  final UserModel userData;
  UserDataSuccess({required this.userData});
}

final class UserDataFailure extends UserDataState {
  final String errMessage;
  UserDataFailure({required this.errMessage});
}
