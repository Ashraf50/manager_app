part of 'auth_bloc.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final String successMessage;
  final String token;
  LoginSuccess({
    required this.successMessage,
    required this.token,
  });
}

final class LoginFailure extends AuthState {
  final String errMessage;
  LoginFailure({required this.errMessage});
}

final class ForgetLoading extends AuthState {}

final class ForgetSuccess extends AuthState {
  final String successMessage;
  ForgetSuccess({
    required this.successMessage,
  });
}

final class ForgetFailure extends AuthState {
  final String errMessage;
  ForgetFailure({required this.errMessage});
}

final class ResetLoading extends AuthState {}

final class ResetSuccess extends AuthState {
  final String successMessage;
  ResetSuccess({
    required this.successMessage,
  });
}

final class ResetFailure extends AuthState {
  final String errMessage;
  ResetFailure({required this.errMessage});
}

final class VerifyCodeLoading extends AuthState {}

final class VerifyCodeSuccess extends AuthState {
  final String successMessage;
  VerifyCodeSuccess({
    required this.successMessage,
  });
}

final class VerifyCodeFailure extends AuthState {
  final String errMessage;
  VerifyCodeFailure({required this.errMessage});
}
