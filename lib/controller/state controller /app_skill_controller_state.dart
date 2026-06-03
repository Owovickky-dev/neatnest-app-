import 'package:neat_nest/data/repo/user_data_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_skill_controller_state.g.dart';

@Riverpod(keepAlive: true)
class AppSkillControllerState extends _$AppSkillControllerState {
  late UserDataRepo _userDataRepo;
  bool _initialized = false;

  @override
  List<String> build() {
    _userDataRepo = UserDataRepo();

    if (!_initialized) {
      _initialized = true;
      getSkills();
    }

    return [];
  }

  Future<void> getSkills() async {
    try {
      final response = await _userDataRepo.getSkillsAvailable();

      if (response.statusCode == 200) {
        final responseData = response.data["data"];

        if (!ref.mounted) return;

        state = List<String>.from(responseData);
      }
    } catch (e) {
      rethrow;
    }
  }
}
