// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_time_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BookingTimeState)
const bookingTimeStateProvider = BookingTimeStateProvider._();

final class BookingTimeStateProvider
    extends $NotifierProvider<BookingTimeState, String> {
  const BookingTimeStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingTimeStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingTimeStateHash();

  @$internal
  @override
  BookingTimeState create() => BookingTimeState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$bookingTimeStateHash() => r'bd8a6a728c614b50ae4f9a1b01ce6c1fd45b6bfa';

abstract class _$BookingTimeState extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
