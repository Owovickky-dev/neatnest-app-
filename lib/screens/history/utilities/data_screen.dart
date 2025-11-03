import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({
    super.key,
    required this.text1,
    required this.text2,
    required this.serviceName,
    required this.serviceProvider,
    required this.imagePath,
    required this.price,
    required this.function1,
    required this.function2,
  });

  final String text1;
  final String text2;
  final String serviceName;
  final String serviceProvider;
  final String imagePath;
  final double price;
  final VoidCallback function1;
  final VoidCallback function2;

  String date() {
    DateTime now = DateTime.now();
    String format = DateFormat(' EEEE,dd MMM,yyyy').format(now);
    return format;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.containerLightBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: imagePath,
                        ),
                      ),
                    ),
                    10.wt,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        primaryText(text: serviceName),
                        5.ht,
                        secondaryText(text: serviceProvider),
                      ],
                    ),
                  ],
                ),
                10.ht,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        primaryText(
                          text: date(),
                          fontSize: 10.sp,
                          color: AppColors.blackTextColor.withValues(
                            alpha: 0.75,
                          ),
                        ),
                        secondaryText(text: 'Date'),
                      ],
                    ),
                    Row(
                      children: [
                        primaryText(text: '\$${price.toString()}'),
                        secondaryText(text: '/hour'),
                      ],
                    ),
                  ],
                ),
                25.ht,
                DottedLine(
                  dashColor: AppColors.secondaryTextColor.withValues(alpha: .5),
                ),
                25.ht,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      text: text1,
                      bckColor: AppColors.primaryColor.withValues(alpha: .1),
                      textColor: AppColors.blackTextColor,
                      function: function1,
                    ),
                    AppButton(
                      text: text2,
                      bckColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      function: function2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
