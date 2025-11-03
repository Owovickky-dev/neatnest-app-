import 'package:neat_nest/models/verification_state_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verification_state_set.g.dart';

@riverpod
class VerificationStateSet extends _$VerificationStateSet {
  @override
  List<VerificationStateModel> build() {
    return [
      VerificationStateModel(addressState: 0, selfieState: 0, idState: 0),
    ];
  }
}
