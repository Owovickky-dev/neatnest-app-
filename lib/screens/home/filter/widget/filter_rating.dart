import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/widget/app_text.dart';

class FilterRating extends StatelessWidget {
  const FilterRating({
    super.key,
    required this.index,
    this.ratingClicked = false,
    required this.text,
  });

  final int index;
  final bool ratingClicked;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ratingClicked
            ? AppColors.primaryColor.withValues(alpha: 0.2)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: AppColors.ratingStarColor),
          secondaryText(text: text),
        ],
      ),
    );
  }
}
