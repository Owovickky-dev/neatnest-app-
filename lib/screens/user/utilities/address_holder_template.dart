import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class AddressHolderTemplate extends StatelessWidget {
  const AddressHolderTemplate({
    super.key,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    this.postalCode,
    required this.isDefault,
  });

  final String address;
  final String city;
  final String state;
  final String country;
  final String? postalCode;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          secondaryText(text: address),
          10.ht,
          secondaryText(text: city),
          10.ht,
          secondaryText(text: "$state,  $country"),
          ?postalCode != null
              ? Column(
                  children: [
                    10.ht,
                    secondaryText(text: postalCode!),
                  ],
                )
              : null,
          ?isDefault
              ? Column(
                  children: [
                    10.ht,
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primaryColor,
                          size: 12.sp,
                        ),
                        10.wt,
                        secondaryText(
                          text: "Default Address",
                          color: AppColors.primaryColor,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ],
                )
              : null,

          20.ht,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isDefault
                  ? secondaryText(text: "SET AS DEFAULT")
                  : GestureDetector(
                      onTap: () {
                        print("Gesture  detected ");
                      },
                      child: secondaryText(
                        text: "SET AS DEFAULT",
                        color: AppColors.primaryColor,
                      ),
                    ),
              Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                  ),
                  10.wt,
                  Icon(
                    Icons.delete,
                    color: AppColors.primaryColor.withValues(alpha: 0.8),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
