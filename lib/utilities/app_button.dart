import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/widget/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.bckColor,
    required this.textColor,
    this.width,
    required this.function,
    this.verticalHeight,
    this.fontSize,
  });

  final String text;
  final Color bckColor;
  final Color textColor;
  final double? width;
  final double? fontSize;
  final double? verticalHeight;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: width?.w ?? 135.w,
        padding: EdgeInsets.symmetric(vertical: verticalHeight?.h ?? 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: bckColor,
        ),
        child: Center(
          child: primaryText(
            text: text,
            color: textColor,
            fontSize: fontSize?.sp ?? 12.sp,
          ),
        ),
      ),
    );
  }
}
