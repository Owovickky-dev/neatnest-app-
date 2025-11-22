import 'package:flutter/material.dart';

import '../../../../../widget/app_bar_holder.dart';

class ChangeMailScreen extends StatelessWidget {
  const ChangeMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBarHolder(title: 'Change mail'));
  }
}
