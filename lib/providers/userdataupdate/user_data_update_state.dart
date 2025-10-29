import 'package:neat_nest/models/edit_user_info_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_update_state.g.dart';

@Riverpod(keepAlive: true)
class UserDataUpdateState extends _$UserDataUpdateState {
  @override
  EditUserInfoModel build() {
    return EditUserInfoModel();
  }
}
