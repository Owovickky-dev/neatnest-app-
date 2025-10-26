import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_display_data_state.g.dart';

@Riverpod(keepAlive: true)
class HomeDisplayDataState extends _$HomeDisplayDataState {
  @override
  bool build() {
    return false;
  }

  void displayData(bool data) {
    state = data;
  }
}
