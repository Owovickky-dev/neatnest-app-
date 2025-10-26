import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/booking/booking_screen.dart';
import 'package:neat_nest/utilities/app_data.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../widget/app_text.dart';

class FavouriteDataHolder extends StatefulWidget {
  const FavouriteDataHolder({super.key, required this.index});

  final int index;

  @override
  State<FavouriteDataHolder> createState() => _FavouriteDataHolderState();
}

class _FavouriteDataHolderState extends State<FavouriteDataHolder> {
  bool isClicked = false;

  String randNumber() {
    final rating = (Random().nextDouble() * 4) + 1;
    return rating.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final str = randNumber();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingScreen(index: widget.index),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        constraints: BoxConstraints(maxWidth: 150.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.containerLightBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.r),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: AppData.popularImagesPath[widget.index],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  10.ht,
                  // Service name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: primaryText(
                            text: AppData.serviceName[widget.index],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            fontSize: 16.sp, // Reduced font size
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.ratingStarColor,
                            size: 14.sp,
                          ),
                          3.wt,
                          primaryText(text: str, fontSize: 14.sp),
                        ],
                      ),
                    ],
                  ),
                  10.ht,
                  // Service provider name
                  SizedBox(
                    width: double.infinity,
                    child: secondaryText(
                      text: AppData.serviceProviderName[widget.index],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  10.ht,
                  // Price row - COMPLETELY REVISED APPROACH
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Use Expanded to force the price section to take available space
                        Expanded(
                          child: Row(
                            children: [
                              primaryText(
                                text: '\$${AppData.price[widget.index]}',
                                fontSize: 13.sp,
                              ),
                              secondaryText(text: '/hour', fontSize: 12.sp),
                            ],
                          ),
                        ),

                        // Favorite icon with fixed size
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isClicked = !isClicked;
                            });
                          },
                          child: Container(
                            width: 20.w,
                            alignment: Alignment.centerRight,
                            child: isClicked
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 18.sp,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.black,
                                    size: 18.sp,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
