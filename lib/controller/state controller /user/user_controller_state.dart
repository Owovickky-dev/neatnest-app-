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
    return null;
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
          final user = UserModel.fromJson(responseData["data"]["loginUser"]);
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

  Future<void> logOut() async {
    await SecureStorageHelper.deleteToken();
    state = null;
  }
}
