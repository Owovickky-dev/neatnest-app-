import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class HomeScreenIcons extends StatelessWidget {
  const HomeScreenIcons({
    super.key,
    this.text,
    this.icons,
    this.radius,
    this.height,
    this.width,
    this.iconColor,
  });

  final String? text;
  final IconData? icons;
  final double? radius;
  final double? height;
  final double? width;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height ?? 50.h,
          width: width ?? 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 25.r),
            color: AppColors.primaryColor.withOpacity(0.1),
          ),
          child: Center(
            child: Icon(icons, color: iconColor ?? AppColors.primaryColor),
          ),
        ),
        5.ht,
        primaryText(text: text ?? "", fontSize: 12),
      ],
    );
  }
}
