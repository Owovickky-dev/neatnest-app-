// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationStateNotifier)
const notificationStateProvider = NotificationStateNotifierProvider._();

final class NotificationStateNotifierProvider
    extends
        $NotifierProvider<NotificationStateNotifier, List<NotificationModel>> {
  const NotificationStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationStateNotifierHash();

  @$internal
  @override
  NotificationStateNotifier create() => NotificationStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<NotificationModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<NotificationModel>>(value),
    );
  }
}

String _$notificationStateNotifierHash() =>
    r'bf1ba5786d67d1b6d2fd63f018bb7e9769547a03';

abstract class _$NotificationStateNotifier
    extends $Notifier<List<NotificationModel>> {
  List<NotificationModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<NotificationModel>, List<NotificationModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<NotificationModel>, List<NotificationModel>>,
              List<NotificationModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
