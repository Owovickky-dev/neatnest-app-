// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_state_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationStateData)
const notificationStateDataProvider = NotificationStateDataProvider._();

final class NotificationStateDataProvider
    extends $NotifierProvider<NotificationStateData, List<NotificationModel>> {
  const NotificationStateDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationStateDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationStateDataHash();

  @$internal
  @override
  NotificationStateData create() => NotificationStateData();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<NotificationModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<NotificationModel>>(value),
    );
  }
}

String _$notificationStateDataHash() =>
    r'569f3ee8bbab3f569d487540961fdfc1715dbba1';

abstract class _$NotificationStateData
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
