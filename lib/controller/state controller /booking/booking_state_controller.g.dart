// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BookingStateController)
const bookingStateControllerProvider = BookingStateControllerProvider._();

final class BookingStateControllerProvider
    extends $AsyncNotifierProvider<BookingStateController, GroupedBookings> {
  const BookingStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingStateControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingStateControllerHash();

  @$internal
  @override
  BookingStateController create() => BookingStateController();
}

String _$bookingStateControllerHash() =>
    r'93f1efdd9205e1591a66a60736888c4a9ac8ca27';

abstract class _$BookingStateController
    extends $AsyncNotifier<GroupedBookings> {
  FutureOr<GroupedBookings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<GroupedBookings>, GroupedBookings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GroupedBookings>, GroupedBookings>,
              AsyncValue<GroupedBookings>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
