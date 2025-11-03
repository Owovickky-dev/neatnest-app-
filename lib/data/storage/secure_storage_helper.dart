import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:neat_nest/models/user_model.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static const String accessToken = "token";
  static const String refreshToken = "refreshToken";
  static const String _userDataKey = "user_data";

  static Future<void> saveToken(String token) async {
    await _storage.write(key: accessToken, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: accessToken);
  }

  static Future<void> deleteToken() async {
    return await _storage.delete(key: accessToken);
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
}
