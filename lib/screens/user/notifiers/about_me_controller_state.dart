import 'package:neat_nest/data/repo/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'about_me_controller_state.g.dart';

@riverpod
class AboutMeControllerState extends _$AboutMeControllerState {
  late AuthRepo _authRepo;
  @override
  String build() {
    _authRepo = AuthRepo();
    return "";
  }

  Future<void> postAboutMe(String aboutMe) async {
    try {
      final response = await _authRepo.updateAboutMe(aboutMe);
      if (response.statusCode == 201) {
        final responseData = response.data["data"];
        state = responseData;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getAboutMe() async {
    try {
      final response = await _authRepo.getAboutMe();
      if (response.statusCode == 200) {
        final responseData = response.data["data"];
        state = responseData;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAboutMe() async {
    try {
      final response = await _authRepo.deleAboutMe();
      if (response.statusCode == 200) {
        state = "";
      }
    } catch (e) {
      rethrow;
    }
  }
}
