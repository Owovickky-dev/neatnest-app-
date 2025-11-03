import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'on_submit_index.g.dart';

@riverpod
class OnSubmitIndex extends _$OnSubmitIndex {
  @override
  int build() {
    return 0;
  }

  void updateOnSubmitIndex(int value) {
    state = value;
  }
}
