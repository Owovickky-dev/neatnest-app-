import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class VerificationOptionsItemsHolder extends StatelessWidget {
  const VerificationOptionsItemsHolder({
    super.key,
    required this.title,
    required this.subTitle,
    this.isClicked = false,
    required this.icons,
    this.textIn,
  });

  final bool isClicked;
  final String title;
  final String subTitle;
  final IconData icons;
  final String? textIn;

  final List<String> verify = const [
    "Not-started",
    "Completed",
    "Pending",
    "Cancel",
  ];

  IconData? verification(String text) {
    switch (text) {
      case "Cancel":
        return FontAwesomeIcons.xmark;
      case "Pending":
        return FontAwesomeIcons.spinner;
      case "Completed":
        return FontAwesomeIcons.check;
      case "Not-started":
        return FontAwesomeIcons.clock;
      default:
        return null;
    }
  }

  Color? verificationColor(String text) {
    switch (text) {
      case "Cancel":
        return Colors.red;
      case "Pending":
        return Colors.orange;
      case "Completed":
        return AppColors.primaryColor;
      case "Not-started":
        return Colors.grey;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isClicked ? AppColors.primaryColor : Colors.grey,
          width: isClicked ? 2 : 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: isClicked
                      ? AppColors.primaryColor
                      : Colors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icons,
                  color: isClicked ? Colors.white : Colors.grey,
                ),
              ),
              10.wt,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  primaryText(text: title, fontSize: 14.sp),
                  secondaryText(text: subTitle, fontSize: 12.sp),
                ],
              ),
            ],
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: verificationColor(textIn ?? verify[0]),
            ),
            child: Center(
              child: Icon(
                verification(textIn ?? verify[0]),
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
