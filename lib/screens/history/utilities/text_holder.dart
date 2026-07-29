import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/widget/app_text.dart';

Widget textHolder({required String titleText, required String text}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      secondaryText(text: titleText, fontSize: 13.sp),
      primaryText(text: text, fontSize: 16.sp),
    ],
  );
}

Widget textHolderPayment({required String titleText, required String text}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      secondaryText(text: titleText, fontSize: 13.sp),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Center(
          child: primaryText(
            text: text,
            fontSize: 16.sp,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    ],
  );
}
