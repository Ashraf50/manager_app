import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiHelper {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _isRefreshing = false;
  final List<void Function(String)> _requestQueue = [];
  ApiHelper() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final requiresToken = options.headers['requiresToken'] != false;
          if (requiresToken) {
            final token = await _secureStorage.read(key: 'auth_token');
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          final response = error.response;
          final requestOptions = error.requestOptions;
          final requiresToken =
              requestOptions.headers['requiresToken'] != false;
          if (response?.statusCode == 401 && requiresToken) {
            if (_isRefreshing) {
              final completer = Completer<Response>();
              _requestQueue.add((newToken) async {
                try {
                  final retryOptions = Options(
                    method: requestOptions.method,
                    headers: {
                      ...requestOptions.headers,
                      'Authorization': 'Bearer $newToken',
                    },
                  );
                  final newResponse = await _dio.request(
                    requestOptions.path,
                    data: requestOptions.data,
                    queryParameters: requestOptions.queryParameters,
                    options: retryOptions,
                  );
                  completer.complete(newResponse);
                } catch (e) {
                  completer.completeError(e);
                }
              });
              return handler.resolve(await completer.future);
            }
            _isRefreshing = true;
            try {
              final refreshToken =
                  await _secureStorage.read(key: 'refresh_token');
              if (refreshToken == null || refreshToken.isEmpty) {
                throw Exception('No refresh token available');
              }
              final refreshResponse = await _dio.post(
                'https://graduation.arabic4u.org/auth/refresh_tokens/refresh',
                data: {'refresh_token': refreshToken},
                options: Options(headers: {'requiresToken': false}),
              );
              final newToken = refreshResponse.data['data']['token'];
              final newRefreshToken =
                  refreshResponse.data['data']['refresh_token'];
              if (newToken == null || newRefreshToken == null) {
                throw Exception('Invalid tokens received');
              }
              await _secureStorage.write(key: 'auth_token', value: newToken);
              await _secureStorage.write(
                  key: 'refresh_token', value: newRefreshToken);
              final queueCopy = List.of(_requestQueue);
              _requestQueue.clear();
              for (var callback in queueCopy) {
                callback(newToken);
              }
              requestOptions.headers['Authorization'] = 'Bearer $newToken';
              final retryResponse = await _dio.request(
                requestOptions.path,
                data: requestOptions.data,
                queryParameters: requestOptions.queryParameters,
                options: Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers,
                ),
              );
              return handler.resolve(retryResponse);
            } catch (e) {
              await _secureStorage.delete(key: 'auth_token');
              await _secureStorage.delete(key: 'refresh_token');
              final queueCopy = List.of(_requestQueue);
              _requestQueue.clear();
              for (var callback in queueCopy) {
                callback('');
              }
              return handler.reject(error);
            } finally {
              _isRefreshing = false;
            }
          }
          return handler.next(error);
        },
      ),
    );
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
  Future<Response> get(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(
        url,
        queryParameters: queryParameters,
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

  // PATCH method
  Future<Response> patch(String url,
      {dynamic data, Map<String, String>? headers}) async {
    try {
      return await _dio.patch(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }
}
