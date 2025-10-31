import 'package:flutter/material.dart';

import '../../../../widget/app_bar_holder.dart';

class UserPaymentMethod extends StatelessWidget {
  const UserPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Payment  Method'),
      body: Center(child: Text("User page")),
    );
  }
}
