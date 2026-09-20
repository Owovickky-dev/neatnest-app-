// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_tracking.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationTracking)
const notificationTrackingProvider = NotificationTrackingProvider._();

final class NotificationTrackingProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  const NotificationTrackingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationTrackingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationTrackingHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return notificationTracking(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$notificationTrackingHash() =>
    r'b22936bdb1aec59fb5a07c9228483281d78a03f5';
