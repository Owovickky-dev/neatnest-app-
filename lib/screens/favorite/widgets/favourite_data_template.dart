import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/favourite_controller.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../utilities/constant/colors.dart';

class FavouriteDataTemplate extends ConsumerWidget {
  FavouriteDataTemplate({
    super.key,
    required this.title,
    required this.adsOwner,
    required this.price,
    required this.image,
    required this.favId,
  });

  final FavouriteController favouriteController = FavouriteController();

  final String title;
  final String adsOwner;
  final num price;
  final String image;
  final String favId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.primaryColor.withValues(alpha: 0.1),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: 100.w,
                ),
              ),
              10.wt,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  secondaryText(text: title),
                  10.ht,
                  secondaryText(text: adsOwner),
                  10.ht,
                  secondaryText(text: "\$ $price"),
                ],
              ),
            ],
          ),
          10.ht,
          DottedLine(
            dashColor: AppColors.secondaryTextColor.withValues(alpha: .5),
          ),
          10.ht,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  favouriteController.removeFavourite(context, favId, ref);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  child: primaryText(
                    text: "Remove",
                    color: Colors.white,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                    color: AppColors.primaryColor,
                  ),
                  child: primaryText(
                    text: "Order Now",
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
