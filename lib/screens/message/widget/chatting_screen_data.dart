import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class ChattingScreenData extends StatelessWidget {
  const ChattingScreenData({
    super.key,
    required this.message,
    required this.isSender,
    required this.time,
  });

  final String message;
  final bool isSender;
  final String time; // chnage to time when all is set

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        padding: EdgeInsets.all(12.sp),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isSender
              ? AppColors.primaryColor
              : AppColors.containerLightBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
            topRight: isSender ? Radius.circular(0) : Radius.circular(10.r),
            topLeft: isSender ? Radius.circular(10.r) : Radius.circular(0),
          ),
        ),
        child: Column(
          children: [
            primaryText(
              text: message,
              color: isSender ? Colors.white : AppColors.blackTextColor,
            ),
            5.ht,
            Align(
              alignment: Alignment.bottomRight,
              child: secondaryText(
                text: time,
                fontSize: 8.sp,
                color: isSender ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
