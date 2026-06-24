// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_verification_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserVerificationState)
const userVerificationStateProvider = UserVerificationStateProvider._();

final class UserVerificationStateProvider
    extends $AsyncNotifierProvider<UserVerificationState, VerificationModel?> {
  const UserVerificationStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userVerificationStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userVerificationStateHash();

  @$internal
  @override
  UserVerificationState create() => UserVerificationState();
}

String _$userVerificationStateHash() =>
    r'9e234d9b8c8d6bcd4faccff453ba05bd5d3d4a90';

abstract class _$UserVerificationState
    extends $AsyncNotifier<VerificationModel?> {
  FutureOr<VerificationModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<VerificationModel?>, VerificationModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VerificationModel?>, VerificationModel?>,
              AsyncValue<VerificationModel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
