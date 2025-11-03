import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utilities/constant/colors.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({
    super.key,
    required this.icons,
    this.function,
    this.height,
    this.width,
    this.bckColor,
    this.iconColor,
    this.radius,
  });

  final IconData icons;
  final VoidCallback? function;
  final double? height;
  final double? width;
  final Color? bckColor;
  final Color? iconColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: height ?? 40.h,
        width: width ?? 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius?.r ?? 20.r),
          color: bckColor ?? AppColors.containerLightBackground,
        ),
        child: Center(
          child: Icon(icons, color: iconColor ?? AppColors.blackTextColor),
        ),
      ),
    );
  }
}
