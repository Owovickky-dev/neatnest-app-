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
    extends $AsyncNotifierProvider<BookingStateController, List<BookingModel>> {
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
    r'9a6a2bc03c988f6e66621934db57004570eeb3f2';

abstract class _$BookingStateController
    extends $AsyncNotifier<List<BookingModel>> {
  FutureOr<List<BookingModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<BookingModel>>, List<BookingModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BookingModel>>, List<BookingModel>>,
              AsyncValue<List<BookingModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
