part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({
    required this.email,
    required this.password,
  });
}

class ForgetPassEvent extends AuthEvent {
  final String email;
  ForgetPassEvent({
    required this.email,
  });
}

class ResetPassEvent extends AuthEvent {
  final String email;
  final String code;
  final String password;
  final String passwordConfirm;
  ResetPassEvent({
    required this.email,
    required this.code,
    required this.password,
    required this.passwordConfirm,
  });
}

class VerifyCodeEvent extends AuthEvent {
  final String email;
  final String code;
  VerifyCodeEvent({
    required this.email,
    required this.code,
  });
}
