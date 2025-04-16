import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String?> getToken() async {
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  return await secureStorage.read(key: 'auth_token');
}
