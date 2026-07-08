import 'package:neat_nest/data/repo/user_data_repo.dart';

import '../data/storage/secure_storage_helper.dart';
import '../models/user_model.dart';

class ProfileSecurityController {
  ProfileSecurityController();

  final UserDataRepo _userDataRepo = UserDataRepo();

  void changeMail() {}
  void changeUserName() {}
  void changeDisplayName() {}
  Future<UserModel?> uploadProfilePic(String picPath) async {
    try {
      final response = await _userDataRepo.uploadProfilePics(picPath);

      if (response.statusCode == 200) {
        final updatedUser = UserModel.fromJson(response.data["data"]);
        await SecureStorageHelper.saveUserData(updatedUser);
        return updatedUser;
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
