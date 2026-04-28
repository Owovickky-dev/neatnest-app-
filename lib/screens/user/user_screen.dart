import 'package:flutter/material.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/screens/user/user_profile_screen.dart';
import 'package:neat_nest/screens/user/widgets/in_reg_screen.dart';
import 'package:neat_nest/widget/loading_screen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  Future<bool> _checkUserExist() async {
    return await SecureStorageHelper.isDataStored();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkUserExist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: LoadingScreen()));
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Something went wrong")),
          );
        }

        final isLoggedIn = snapshot.data ?? false;

        if (isLoggedIn) {
          return UserProfileScreen();
        } else {
          return const InRegScreen();
        }
      },
    );
  }
}
