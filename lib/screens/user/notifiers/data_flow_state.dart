import 'package:neat_nest/models/data_flow_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_flow_state.g.dart';

@riverpod
class DataFlowState extends _$DataFlowState {
  @override
  List<DataflowModel> build() {
    return [
      DataflowModel(identityVerifyIndex: 0, methodVerifyIndex: 0),
      DataflowModel(identityVerifyIndex: 0, methodVerifyIndex: 0),
      DataflowModel(identityVerifyIndex: 0, methodVerifyIndex: 0),
    ];
  }

  void updateIdentityIndex(int value) {
    state = [...state.map((item) => item.copyWith(identityVerifyIndex: value))];
  }

  void updateMethodIndex(int value) {
    state = [...state.map((item) => item.copyWith(methodVerifyIndex: value))];
  }

  void updateVerificationStatus(int index, String status) {
    final updated = [...state];
    updated[index] = updated[index].copyWith(verificationStatus: status);
    state = updated;
  }
}
