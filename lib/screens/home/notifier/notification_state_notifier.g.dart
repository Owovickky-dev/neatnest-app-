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
        $AsyncNotifierProvider<
          NotificationStateNotifier,
          List<NotificationModel>
        > {
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
}

String _$notificationStateNotifierHash() =>
    r'566a4e78bf4cf3bf57114a8fe7e7c1b4e4d994a2';

abstract class _$NotificationStateNotifier
    extends $AsyncNotifier<List<NotificationModel>> {
  FutureOr<List<NotificationModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<NotificationModel>>,
              List<NotificationModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<NotificationModel>>,
                List<NotificationModel>
              >,
              AsyncValue<List<NotificationModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
