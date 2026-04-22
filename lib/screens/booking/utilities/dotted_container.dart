import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class DottedContainer extends StatelessWidget {
  const DottedContainer({super.key, required this.text, this.function});

  final String text;
  final VoidCallback? function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: AppColors.primaryColor,
          strokeWidth: 2,
          dashPattern: [6, 8],
          radius: Radius.circular(20.r),
        ),
        child: Container(
          height: 50.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: AppColors.primaryColor),
              10.wt,
              primaryText(
                text: text,
                color: AppColors.primaryColor,
                fontSize: 13.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
