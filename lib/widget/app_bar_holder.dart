import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';

import '../screens/history/utilities/app_bar_icon.dart';
import 'app_text.dart';

class AppBarHolder extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHolder({
    super.key,
    required this.title,
    this.iconName,
    this.function,
  });

  final String title;
  final IconData? iconName;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: AppBarIcon(
        icons: iconName ?? Icons.arrow_back,
        function: function ?? () => AppNavigatorHelper.back(context),
      ),
      title: primaryText(text: title, fontSize: 22.sp),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
