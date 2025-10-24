import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static const String accessToken = "token";
  static const String refreshToken = "refreshToken";

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: accessToken);
  }

  static Future<void> deleteToken() async {
    return await _storage.delete(key: accessToken);
  }
}
