import 'package:neat_nest/data/repo/auth_repo.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/models/user_model.dart';
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

      if (response.statusCode == 201) {
        final responseData = response.data;
        final token = responseData["data"]["token"];
        final refreshToken = responseData["data"]["refreshToken"];
        if (token != null && refreshToken != null) {
          await SecureStorageHelper.saveToken(token);
          await SecureStorageHelper.saveRefreshToken(refreshToken);

          final user = UserModel.fromJson(responseData["data"]["user"]);
          await SecureStorageHelper.saveUserData(user);
          if (!ref.mounted) return;
          state = user;
          return;
        } else {
          throw Exception("No token receive");
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await _authRepo.signIn(email: email, password: password);
      final responseData = response.data;

      if (response.statusCode == 200) {
        final token = responseData['data']['token'];
        final refreshToken = responseData["data"]["refreshToken"];
        if (token != null && refreshToken != null) {
          await SecureStorageHelper.saveToken(token);
          print("access token saved");
          await SecureStorageHelper.saveRefreshToken(refreshToken);
          print("refresh token saved");
          final user = UserModel.fromJson(responseData["data"]["loginUser"]);
          await SecureStorageHelper.saveUserData(user);

          if (ref.mounted) {
            state = user;
          }

          return;
        } else {
          throw Exception("No token received");
        }
      }
    } catch (e, stack) {
      print("❌ ERROR in UserControllerState.login(): $e");
      print("❌ Stack trace: $stack");
      rethrow;
    }
  }

  Future<void> logOut() async {
    await SecureStorageHelper.deleteToken();
    await SecureStorageHelper.deleteUserData();
    await SecureStorageHelper.deleteRefreshToken();
    state = null;
  }

  Future<void> refreshUserData() async {
    await loadUserData();
  }

  Map<String, dynamic> pendingUserUpdates = {};

  void updatePersonalInformation({
    String? name,
    String? email,
    String? userName,
    String? phoneNumber,
  }) {
    if (name != null) pendingUserUpdates["name"] = name;
    if (email != null) pendingUserUpdates["email"] = email;
    if (userName != null) pendingUserUpdates["username"] = userName;
    if (phoneNumber != null) pendingUserUpdates["phoneNumber"] = phoneNumber;
    print("The newly entered data is $pendingUserUpdates");
  }
}
