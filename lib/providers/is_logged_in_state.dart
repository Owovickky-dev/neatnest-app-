import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_logged_in_state.g.dart';

@riverpod
class IsLoggedInState extends _$IsLoggedInState {
  @override
  bool build() {
    return false;
  }

  void yesLogged(bool data) {
    state = data;
  }
}
