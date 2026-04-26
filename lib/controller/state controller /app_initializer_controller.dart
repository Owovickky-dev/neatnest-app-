import 'package:neat_nest/controller/state%20controller%20/favourite/favourite_state_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_initializer_controller.g.dart';

@riverpod
class AppInitializerController extends _$AppInitializerController {
  @override
  Future<void> build() async {}

  Future<void> loadInitialData() async {
    await ref
        .read(favouriteStateControllerProvider.notifier)
        .getUserFavourite();
  }
}
