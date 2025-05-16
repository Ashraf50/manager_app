import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repo/auth_repo.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          final result = await authRepo.login(
            email: event.email,
            password: event.password,
          );
          if (result['type'] == 'error') {
            await authRepo.clearTokens();
            emit(LoginFailure(errMessage: result['message']));
          } else if (result['type'] == 'success') {
            final user = result['data']['user'];
            final token = result['data']['token'];
            final refreshToken = result['data']['refresh_token'];
            final userId = user['id'].toString();
            await authRepo.saveTokens(token, refreshToken, userId);
            emit(LoginSuccess(successMessage: result['message'], token: token));
          }
        } catch (e) {
          await authRepo.clearTokens();
          emit(LoginFailure(errMessage: _parseError(e)));
        }
      }
      else if (event is ForgetPassEvent) {
        emit(ForgetLoading());
        try {
          final result = await authRepo.forgetPassword(email: event.email);
          if (result['type'] == 'error') {
            final errorDetails = result['data'];
            String errorMessage = result['message'];
            if (errorDetails is Map && errorDetails.containsKey('user')) {
              errorMessage = errorDetails['user'];
            }
            emit(ForgetFailure(errMessage: errorMessage));
          } else if (result['type'] == 'success') {
            emit(ForgetSuccess(successMessage: result['message']));
          }
        } catch (e) {
          emit(ForgetFailure(errMessage: _parseError(e)));
        }
      }
      else if (event is ResetPassEvent) {
        emit(ResetLoading());
        try {
          final result = await authRepo.resetPassword(
            email: event.email,
            code: event.code,
            password: event.password,
            passwordConfirm: event.passwordConfirm,
          );
          if (result['type'] == 'error') {
            emit(ResetFailure(errMessage: result['message']));
          } else if (result['type'] == 'success') {
            emit(ResetSuccess(successMessage: result['message']));
          }
        } catch (e) {
          emit(ResetFailure(errMessage: _parseError(e)));
        }
      }
      else if (event is VerifyCodeEvent) {
        emit(VerifyCodeLoading());
        try {
          final result = await authRepo.verifyCode(
            email: event.email,
            code: event.code,
          );
          if (result['type'] == 'error') {
            final errorDetails = result['data'];
            String errorMessage = result['message'];
            if (errorDetails is Map && errorDetails.containsKey('code')) {
              errorMessage = errorDetails['code'];
            }
            emit(VerifyCodeFailure(errMessage: errorMessage));
          } else if (result['type'] == 'success') {
            emit(VerifyCodeSuccess(successMessage: result['message']));
          }
        } catch (e) {
          emit(VerifyCodeFailure(errMessage: _parseError(e)));
        }
      }
    });
  }

  String _parseError(Object e) {
    if (e is Exception) {
      return e.toString().replaceAll('Exception:', '').trim();
    }
    return 'Something went wrong';
  }
}
