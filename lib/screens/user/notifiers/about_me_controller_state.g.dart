// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_me_controller_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AboutMeControllerState)
const aboutMeControllerStateProvider = AboutMeControllerStateProvider._();

final class AboutMeControllerStateProvider
    extends $NotifierProvider<AboutMeControllerState, String> {
  const AboutMeControllerStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aboutMeControllerStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aboutMeControllerStateHash();

  @$internal
  @override
  AboutMeControllerState create() => AboutMeControllerState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$aboutMeControllerStateHash() =>
    r'497c1c8ae2f284c02b29c8966e21dd401af8c92a';

abstract class _$AboutMeControllerState extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
