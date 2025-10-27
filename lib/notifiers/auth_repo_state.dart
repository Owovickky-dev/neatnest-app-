import 'package:neat_nest/data/repo/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repo_state.g.dart';

@riverpod
class AuthRepoState extends _$AuthRepoState {
  @override
  AuthRepo build() {
    return AuthRepo();
  }
}
