import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
      centerTitle: true,
      leading: AppBarIcon(
        icons: iconName ?? Icons.arrow_back,
        function: function ?? () => context.pop(),
      ),
      title: primaryText(text: title, fontSize: 22.sp),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(color: Colors.grey.withValues(alpha: .5), height: 1),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
