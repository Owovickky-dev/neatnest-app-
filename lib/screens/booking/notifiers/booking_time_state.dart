import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_time_state.g.dart';

@Riverpod(keepAlive: true)
class BookingTimeState extends _$BookingTimeState {
  @override
  String build() {
    return "";
  }

  void datePicked(String value) {
    state = value;
  }
}
