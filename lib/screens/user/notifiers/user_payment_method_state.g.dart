// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_payment_method_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserPaymentMethodState)
const userPaymentMethodStateProvider = UserPaymentMethodStateProvider._();

final class UserPaymentMethodStateProvider
    extends
        $NotifierProvider<
          UserPaymentMethodState,
          List<UserPaymentMethodModel>
        > {
  const UserPaymentMethodStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPaymentMethodStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPaymentMethodStateHash();

  @$internal
  @override
  UserPaymentMethodState create() => UserPaymentMethodState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserPaymentMethodModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserPaymentMethodModel>>(value),
    );
  }
}

String _$userPaymentMethodStateHash() =>
    r'48fbf26f7534cbd445b9862c085f13f52fa67dab';

abstract class _$UserPaymentMethodState
    extends $Notifier<List<UserPaymentMethodModel>> {
  List<UserPaymentMethodModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<List<UserPaymentMethodModel>, List<UserPaymentMethodModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                List<UserPaymentMethodModel>,
                List<UserPaymentMethodModel>
              >,
              List<UserPaymentMethodModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
