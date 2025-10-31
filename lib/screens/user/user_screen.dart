import 'package:flutter/material.dart';
import 'package:neat_nest/screens/user/user_profile_screen.dart';
import 'package:neat_nest/screens/user/widgets/in_reg_screen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key, required this.isDataAvailable});
  final bool isDataAvailable;

  @override
  Widget build(BuildContext context) {
    return isDataAvailable ? UserProfileScreen() : InRegScreen();
  }
}
