import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class NotificationScreenHolder extends StatelessWidget {
  const NotificationScreenHolder({
    super.key,
    required this.title,
    required this.message,
    required this.date,
    required this.isRead,
  });

  final String title;
  final String message;
  final DateTime date;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70.h,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
            decoration: BoxDecoration(
              color: isRead ? Colors.white : AppColors.containerLightBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withValues(
                    alpha: 0.15,
                  ),
                  child: Center(child: primaryText(text: title[0])),
                ),
                10.wt,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          primaryText(text: title, fontSize: 14.sp),
                          secondaryText(
                            text: DateFormat("h:mma").format(date),
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                      5.ht,
                      secondaryText(
                        text: message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
