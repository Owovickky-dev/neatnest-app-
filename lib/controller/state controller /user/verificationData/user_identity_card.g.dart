// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_identity_card.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserIdentityCard)
const userIdentityCardProvider = UserIdentityCardProvider._();

final class UserIdentityCardProvider
    extends $AsyncNotifierProvider<UserIdentityCard, DisplayDataModel?> {
  const UserIdentityCardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userIdentityCardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userIdentityCardHash();

  @$internal
  @override
  UserIdentityCard create() => UserIdentityCard();
}

String _$userIdentityCardHash() => r'b5d318cf3c4135b5e144b150283b9c9bf4b3064d';

abstract class _$UserIdentityCard extends $AsyncNotifier<DisplayDataModel?> {
  FutureOr<DisplayDataModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<DisplayDataModel?>, DisplayDataModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DisplayDataModel?>, DisplayDataModel?>,
              AsyncValue<DisplayDataModel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
