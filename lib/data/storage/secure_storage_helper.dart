import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:neat_nest/models/user_model.dart';
import 'package:neat_nest/screens/user/widgets/verification/model/display_data_model.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static const String accessTokenKey = "token";
  static const String refreshTokenKey = "refresh_token";
  static const String _userDataKey = "user_data";
  static const String resetPasswordToken = "reset_password_token";
  static const String userIdData = "user_id_data";

  static Future<void> saveToken(String token) async {
    await _storage.write(key: accessTokenKey, value: token);
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: refreshTokenKey, value: refreshToken);
  }

  static Future<void> savePasswordResetToken(String resetToken) async {
    await _storage.write(key: resetPasswordToken, value: resetToken);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: refreshTokenKey);
  }

  static Future<String?> getResetPasswordToken() async {
    return await _storage.read(key: resetPasswordToken);
  }

  static Future<void> deleteToken() async {
    return await _storage.delete(key: accessTokenKey);
  }

  static Future<void> deleteRefreshToken() async {
    return await _storage.delete(key: refreshTokenKey);
  }

  static Future<void> deletePasswordToken() async {
    return await _storage.delete(key: resetPasswordToken);
  }

  static Future<void> saveUserData(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toFullJson());
      await _storage.write(key: _userDataKey, value: userJson);
    } catch (e) {
      if (kDebugMode) {
        print("Error in saving the User data $e");
      }
    }
  }

  static Future<void> saveUserId(DisplayDataModel userId) async {
    try {
      final userIds = jsonEncode(userId);
      await _storage.write(key: userIdData, value: userIds);
    } catch (e) {
      print("Error saving the user data");
    }
  }

  static Future<DisplayDataModel?> getUserId() async {
    try {
      final rawUserId = await _storage.read(key: userIdData);
      if (rawUserId != null) {
        final userId = jsonDecode(rawUserId);
        return userId;
      }
    } catch (e) {
      print("Failed to load user data");
    }
    return null;
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

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    final user = await getUserData();
    return token != null && token.isNotEmpty && user != null;
  }

  static Future<void> deleteUserData() async {
    await _storage.delete(key: _userDataKey);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
