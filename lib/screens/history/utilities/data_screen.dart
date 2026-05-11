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
    required this.leftButtonText,
    this.rightButtonText,
    required this.serviceName,
    required this.serviceProvider,
    required this.imagePath,
    required this.price,
    required this.functionLeft,
    required this.functionRight,
    required this.preferredDate,
    this.sender,
    required this.bookingStatus,
    required this.event,
  });

  final String leftButtonText;
  final String? rightButtonText;
  final String serviceName;
  final String serviceProvider;
  final String imagePath;
  final double price;
  final VoidCallback functionLeft;
  final VoidCallback functionRight;
  final String preferredDate;
  final String? sender;
  final String bookingStatus;
  final String event;

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date).toLocal();
    return DateFormat('EEEE, dd, MMM, yyyy').format(parsedDate);
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
                        Row(
                          children: [
                            primaryText(text: "Title: ", fontSize: 16.sp),
                            10.wt,
                            secondaryText(text: serviceName),
                          ],
                        ),
                        5.ht,
                        Row(
                          children: [
                            primaryText(text: "Provider: ", fontSize: 16.sp),
                            10.wt,
                            secondaryText(text: serviceProvider),
                          ],
                        ),
                        5.ht,
                        Row(
                          children: [
                            primaryText(text: "Sender: ", fontSize: 16.sp),
                            10.wt,
                            secondaryText(text: sender ?? ""),
                          ],
                        ),
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
                          text: formatDate(preferredDate),
                          fontSize: 10.sp,
                          color: AppColors.blackTextColor.withValues(
                            alpha: 0.75,
                          ),
                        ),
                        primaryText(text: 'Date', fontSize: 16.sp),
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
                20.ht,
                Row(
                  children: [
                    primaryText(text: "Status:", fontSize: 16.sp),
                    10.wt,
                    secondaryText(text: bookingStatus),
                  ],
                ),
                20.ht,
                Row(
                  children: [
                    primaryText(text: "Reason:", fontSize: 16.sp),
                    10.wt,
                    Expanded(child: secondaryText(text: event, maxLines: null)),
                  ],
                ),
                20.ht,
                DottedLine(
                  dashColor: AppColors.secondaryTextColor.withValues(alpha: .5),
                ),
                25.ht,
                rightButtonText == null
                    ? Center(
                        child: AppButton(
                          text: leftButtonText,
                          bckColor: AppColors.primaryColor,
                          textColor: Colors.white,
                          function: functionLeft,
                          fontSize: 20.sp,
                          width: 150.w,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            text: leftButtonText,
                            bckColor: AppColors.primaryColor.withValues(
                              alpha: .1,
                            ),
                            textColor: AppColors.blackTextColor,
                            function: functionLeft,
                          ),
                          AppButton(
                            text: rightButtonText!,
                            bckColor: AppColors.primaryColor,
                            textColor: Colors.white,
                            function: functionRight,
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
