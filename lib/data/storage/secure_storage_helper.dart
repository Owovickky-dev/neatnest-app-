import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:neat_nest/models/user_model.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static const String accessTokenKey = "token";
  static const String refreshTokenKey = "refresh_token";
  static const String _userDataKey = "user_data";

  static Future<void> saveToken(String token) async {
    await _storage.write(key: accessTokenKey, value: token);
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: refreshTokenKey, value: refreshToken);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: refreshTokenKey);
  }

  static Future<void> deleteToken() async {
    return await _storage.delete(key: accessTokenKey);
  }

  static Future<void> deleteRefreshToken() async {
    return await _storage.delete(key: refreshTokenKey);
  }

  static Future<void> saveUserData(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toFullJson());
      await _storage.write(key: _userDataKey, value: userJson);
    } catch (e) {
      print("Error in saving the User data $e");
    }
  }

  static Future<UserModel?> getUserData() async {
    try {
      final userJson = await _storage.read(key: _userDataKey);
      if (userJson != null) {
        final userMapData = jsonDecode(userJson) as Map<String, dynamic>;
        final userData = UserModel.fromJson(userMapData);
        return userData;
      }
    } catch (e) {
      print("Error reading the user data $e");
    }
    return null;
  }

  static Future<bool> isDataStored() async {
    final isData = await getUserData();
    return isData != null;
  }

  static Future<void> deleteUserData() async {
    await _storage.delete(key: _userDataKey);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
    print("All storage cleared");
  }
}
