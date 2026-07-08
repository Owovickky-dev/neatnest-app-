import 'package:dio/dio.dart';
import 'package:neat_nest/controller/sign_in_controller.dart';
import 'package:neat_nest/data/repo/auth_repo.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/models/update_personal_profile_model.dart';
import 'package:neat_nest/models/user_model.dart';
import 'package:neat_nest/utilities/api_error_handler.dart';
import 'package:neat_nest/widget/app_notification.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller_state.g.dart';

@riverpod
class UserControllerState extends _$UserControllerState {
  late AuthRepo _authRepo;
  @override
  UserModel? build() {
    _authRepo = AuthRepo();
    loadUserData();
    return null;
  }

  Future<void> loadUserData() async {
    try {
      final user = await SecureStorageHelper.getUserData();
      if (user != null) {
        if (!ref.mounted) return;
        state = user;
      }
    } catch (e) {
      print("Error loading the user data from local storage $e");
    }
  }

  Future<void> register(UserModel userModel) async {
    try {
      final response = await _authRepo.signUp(userModel);
      if (response.statusCode != 201) {
        throw Exception(response.data["message"] ?? "Registration failed");
      }
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.getErrorMessage(e));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(LoginModel data) async {
    try {
      final response = await _authRepo.signIn(data);

      final responseData = response.data;
      if (response.statusCode == 200) {
        final token = responseData['data']['token'];
        final refreshToken = responseData["data"]["refreshToken"];
        if (token != null && refreshToken != null) {
          await SecureStorageHelper.saveToken(token);
          await SecureStorageHelper.saveRefreshToken(refreshToken);
          final user = UserModel.fromJson(responseData["data"]["loginUser"]);
          await SecureStorageHelper.saveUserData(user);
          if (ref.mounted) {
            state = user;
          }
          return;
        } else {
          throw Exception("No token received");
        }
      } else {
        throw Exception(responseData["message"] ?? "Login failed");
      }
    } on DioException catch (e) {
      print(e.stackTrace);
      throw Exception(ApiErrorHandler.getErrorMessage(e));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      final response = await _authRepo.signOut();

      if (response.statusCode == 201) {
        await SecureStorageHelper.deleteToken();
        await SecureStorageHelper.deleteUserData();
        await SecureStorageHelper.deleteRefreshToken();
        state = null;
      }
    } catch (e) {
      showErrorNotification(message: "Failed to logout");
      print("Failed to logout");
      print(e);
    }
  }

  Future<void> refreshUserData() async {
    await loadUserData();
  }

  Future<void> updatePersonalInfo(
    UpdatePersonalProfileModel updatePInfo,
  ) async {
    try {
      final response = await _authRepo.updateMyPersonal(updatePInfo);
      if (response.statusCode == 201) {}
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.getErrorMessage(e));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateVerificationStarted(bool value) async {
    if (state == null) return;
    final updatedUser = state!.copyWith(verificationStarted: value);
    state = updatedUser;
    await SecureStorageHelper.saveUserData(updatedUser);
  }
}
