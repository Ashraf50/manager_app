import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constant/app_strings.dart';

class ApiHelper {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  ApiHelper() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _secureStorage.read(key: 'refresh_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final refreshToken = await _secureStorage.read(key: 'refresh_token');
          if (refreshToken != null) {
            try {
              final refreshResponse = await Dio().post(
                '${AppStrings.baseUrl}/auth/refresh_tokens/refresh',
                data: {
                  "token": refreshToken,
                },
              );
              final newToken = refreshResponse.data['data']['token'];
              final newRefreshToken =
                  refreshResponse.data['data']['refreshToken'];
              await _secureStorage.write(key: 'auth_token', value: newToken);
              if (newRefreshToken != null) {
                await _secureStorage.write(
                    key: 'refresh_token', value: newRefreshToken);
              }
              final options = error.requestOptions;
              options.headers['Authorization'] = 'Bearer $newToken';
              final retryResponse = await _dio.fetch(options);
              return handler.resolve(retryResponse);
            } catch (e) {
              await _secureStorage.delete(key: 'auth_token');
              await _secureStorage.delete(key: 'refresh_token');
              return handler.reject(error);
            }
          }
        }
        return handler.next(error);
      },
    ));
  }

  // POST method
  Future<Response> post(String url, dynamic data,
      {Map<String, String>? headers}) async {
    try {
      var response = await _dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // GET method
  Future<Response> get(String url, {Map<String, String>? headers}) async {
    try {
      return await _dio.get(
        url,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }

  // DELETE method
  Future<Response> delete(String url,
      {dynamic data, Map<String, String>? headers}) async {
    try {
      return await _dio.delete(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }

  // PUT method
  Future<Response> put(String url, dynamic data,
      {Map<String, String>? headers}) async {
    try {
      return await _dio.put(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }
}
