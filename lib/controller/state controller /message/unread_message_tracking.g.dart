// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_message_tracking.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(unreadMessageTracking)
const unreadMessageTrackingProvider = UnreadMessageTrackingProvider._();

final class UnreadMessageTrackingProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  const UnreadMessageTrackingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadMessageTrackingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadMessageTrackingHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return unreadMessageTracking(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$unreadMessageTrackingHash() =>
    r'fb8ce5f80a186dc9b9bd9ba454067b0934e6ff86';
