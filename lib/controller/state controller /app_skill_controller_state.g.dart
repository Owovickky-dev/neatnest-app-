// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_skill_controller_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppSkillControllerState)
const appSkillControllerStateProvider = AppSkillControllerStateProvider._();

final class AppSkillControllerStateProvider
    extends $NotifierProvider<AppSkillControllerState, List<String>> {
  const AppSkillControllerStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSkillControllerStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSkillControllerStateHash();

  @$internal
  @override
  AppSkillControllerState create() => AppSkillControllerState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$appSkillControllerStateHash() =>
    r'59a28e8c9a0a1c15e921b3fdc92ec431fb1a581e';

abstract class _$AppSkillControllerState extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
