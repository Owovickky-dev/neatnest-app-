import 'package:neat_nest/data/repo/verification_repo.dart';
import 'package:neat_nest/models/verification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_verification_state.g.dart';

@riverpod
class UserVerificationState extends _$UserVerificationState {
  late VerificationRepo _verificationRepo;
  @override
  Future<VerificationModel?> build() async {
    _verificationRepo = VerificationRepo();
    return await getUserVerificationStatus();
  }

  Future<VerificationModel?> getUserVerificationStatus() async {
    try {
      final response = await _verificationRepo.getUserVerificationStatus();
      final responseData = response.data["data"];
      return VerificationModel.fromJson(responseData);
    } catch (e, stack) {
      print(e.toString());
      print(stack);
      return null;
    }
  }
}
