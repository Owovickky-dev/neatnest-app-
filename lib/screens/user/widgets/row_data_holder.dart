import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class RowDataHolder extends StatelessWidget {
  const RowDataHolder({
    super.key,
    required this.text,
    required this.icons,
    required this.function,
  });

  final String text;
  final IconData icons;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.containerLightBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.w),
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21.r),
                  color: AppColors.primaryColor.withOpacity(0.2),
                ),
                child: Center(
                  child: Icon(icons, color: AppColors.primaryColor, size: 20.r),
                ),
              ),
              10.wt,
              secondaryText(text: text, fontSize: 15.sp),
            ],
          ),
          GestureDetector(
            onTap: function,
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
