// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repo_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthRepoState)
const authRepoStateProvider = AuthRepoStateProvider._();

final class AuthRepoStateProvider
    extends $NotifierProvider<AuthRepoState, AuthRepo> {
  const AuthRepoStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepoStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepoStateHash();

  @$internal
  @override
  AuthRepoState create() => AuthRepoState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepo>(value),
    );
  }
}

String _$authRepoStateHash() => r'8614340dd5166fd3147d0ea8960b7d5ac712b662';

abstract class _$AuthRepoState extends $Notifier<AuthRepo> {
  AuthRepo build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AuthRepo, AuthRepo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthRepo, AuthRepo>,
              AuthRepo,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
