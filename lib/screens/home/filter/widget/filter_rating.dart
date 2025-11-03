import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/app_data.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/widget/app_text.dart';

class FilterRating extends StatelessWidget {
  const FilterRating({
    super.key,
    required this.index,
    this.ratingClicked = false,
  });

  final int index;
  final bool ratingClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ratingClicked
            ? AppColors.primaryColor.withValues(alpha: 0.2)
            : AppColors.containerLightBackground,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: AppColors.ratingStarColor),
          secondaryText(text: AppData.ratingTextRange[index]),
        ],
      ),
    );
  }
}
