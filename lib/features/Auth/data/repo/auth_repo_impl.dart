import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:manager_app/features/Auth/data/repo/auth_repo.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/helper/api_helper.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiHelper apiHelper;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  AuthRepoImpl(this.apiHelper);
  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiHelper.post(
        '${AppStrings.baseUrl}/auth/login',
        {
          'email': email,
          'password': password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await secureStorage.containsKey(key: 'auth_token');
  }
  @override
  Future<void> logout() async {
    await secureStorage.delete(key: 'auth_token');
  }

  @override
  Future<Map<String, dynamic>> forgetPassword({required String email}) async {
    try {
      final response = await apiHelper.post(
        '${AppStrings.baseUrl}/auth/password/forgot_password',
        {'handle': email},
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception('Failed to send password reset request: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final response = await apiHelper.post(
        '${AppStrings.baseUrl}/auth/password/reset_password',
        {
          'handle': email,
          'code': code,
          'password': password,
          'password_confirmation': passwordConfirm,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> verifyCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await apiHelper.post(
        '${AppStrings.baseUrl}/auth/password/validate_code',
        {'handle': email, 'code': code},
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception('Failed to verify code: $e');
    }
  }

  Exception handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final errorData = e.response?.data;
      if (errorData is Map<String, dynamic>) {
        final message = errorData['message'] ?? 'An unexpected error occurred';
        return Exception(message);
      }
    }
    return Exception('Connection error. Please try again.');
  }
}

Exception handleDioError(DioException e) {
  if (e.response != null && e.response?.data != null) {
    final errorData = e.response?.data;

    if (errorData is Map<String, dynamic>) {
      final message = errorData['message'] ?? 'An unexpected error occurred';
      return Exception(message);
    }
  }
  return Exception('Connection error. Please try again.');
}
