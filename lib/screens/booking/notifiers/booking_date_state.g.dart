// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_date_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BookingDateState)
const bookingDateStateProvider = BookingDateStateProvider._();

final class BookingDateStateProvider
    extends $NotifierProvider<BookingDateState, DateTime> {
  const BookingDateStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingDateStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingDateStateHash();

  @$internal
  @override
  BookingDateState create() => BookingDateState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$bookingDateStateHash() => r'b804ad073cddc4d916cdc764d1b5de22905bd735';

abstract class _$BookingDateState extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
