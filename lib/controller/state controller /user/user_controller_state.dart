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
        if (ref.mounted) {
          state = user;
          print("Data loaded successfully: ${user.name}");
        } else {
          print("⚠️ Provider disposed, but user data saved to storage");
        }
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

        if (token != null) {
          await SecureStorageHelper.saveToken(token);
          final user = UserModel.fromJson(responseData["data"]["user"]);
          await SecureStorageHelper.saveUserData(user);
          if (!ref.mounted) return;
          state = user;
          return;
        } else {
          throw Exception("No token receive");
        }
      }
    } catch (e, stack) {
      print("❌ ERROR in UserControllerState.register(): $e");
      print("❌ Stack trace: $stack");
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await _authRepo.signIn(email: email, password: password);
      final responseData = response.data;

      if (response.statusCode == 200) {
        final token = responseData['data']['token'];
        if (token != null) {
          await SecureStorageHelper.saveToken(token);
          print("✅ Token saved successfully");

          final user = UserModel.fromJson(responseData["data"]["loginUser"]);
          await SecureStorageHelper.saveUserData(user);
          print("Data succesfully save to the secure folder helper");

          if (ref.mounted) {
            state = user;
            print("🎯 STATE UPDATED SUCCESSFULLY - User: ${user.name}");
          } else {
            print("⚠️ Provider disposed,  for the normal state");
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
