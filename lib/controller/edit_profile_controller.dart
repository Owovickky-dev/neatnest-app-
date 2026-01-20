import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';

class EditProfileController {
  EditProfileController();

  TextEditingController fNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  void verifiedDetails(WidgetRef ref) {
    final preData = ref.watch(userControllerStateProvider);
    fNameController.text = preData!.name;
    userNameController.text = preData.username;
  }

  void saveData() {
    final String userName;
    final String fullName;
    final String password;

    userName = userNameController.text.trim();
    fullName = fNameController.text.trim();
    password = userPassword.text.trim();
  }
}
