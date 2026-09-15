import 'package:neat_nest/data/repo/user_data_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_skill_controller_state.g.dart';

@Riverpod(keepAlive: true)
class AppSkillControllerState extends _$AppSkillControllerState {
  late UserDataRepo _userDataRepo;

  @override
  List<String> build() {
    _userDataRepo = UserDataRepo();

    return [];
  }

  Future<void> getSkills({bool forceRefresh = false}) async {
    // If categories have already been loaded,
    // don't make another API request.
    if (state.isNotEmpty && !forceRefresh) {
      return;
    }

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
