import 'package:neat_nest/data/repo/verification_repo.dart';
import 'package:neat_nest/screens/user/widgets/verification/model/display_data_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_identity_card.g.dart';

@riverpod
class UserIdentityCard extends _$UserIdentityCard {
  late VerificationRepo _verificationRepo;
  @override
  Future<DisplayDataModel?> build() {
    _verificationRepo = VerificationRepo();
    return getUserId();
  }

  Future<DisplayDataModel?> getUserId() async {
    try {
      final response = await _verificationRepo.getUserId();

      if (response.statusCode == 200) {
        return DisplayDataModel.fromJson(response.data["data"]);
      }
    } catch (e, stack) {
      print(e.toString());
      print(stack);
      return null;
    }
    return null;
  }
}
