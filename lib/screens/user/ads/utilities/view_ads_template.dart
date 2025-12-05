import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/ads_controller.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../utilities/constant/colors.dart';

class ViewAdsTemplate extends ConsumerStatefulWidget {
  const ViewAdsTemplate({
    super.key,
    required this.title,
    required this.category,
    required this.basePrice,
    required this.aOrders,
    required this.adsId,
    this.controller,
  });

  final String title;
  final String category;
  final num basePrice;
  final num aOrders;
  final String adsId;
  final AdsController? controller;

  @override
  ConsumerState<ViewAdsTemplate> createState() => _ViewAdsTemplateState();
}

class _ViewAdsTemplateState extends ConsumerState<ViewAdsTemplate> {
  final AdsController _adsController = AdsController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.primaryColor.withValues(alpha: 0.1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              primaryText(
                text: "Title: ",
                fontSize: 14.sp,
                color: Colors.black45,
              ),
              10.wt,
              secondaryText(text: widget.title, fontSize: 12.sp),
            ],
          ),
          15.ht,
          Row(
            children: [
              primaryText(
                text: "Category: ",
                fontSize: 14.sp,
                color: Colors.black45,
              ),
              10.wt,
              secondaryText(text: widget.category, fontSize: 12.sp),
            ],
          ),
          15.ht,
          Row(
            children: [
              primaryText(
                text: "Base Price: ",
                fontSize: 14.sp,
                color: Colors.black45,
              ),
              10.wt,
              secondaryText(
                text: "\$${widget.basePrice.toString()}",
                fontSize: 12.sp,
              ),
            ],
          ),
          15.ht,
          Row(
            children: [
              primaryText(
                text: "Active Orders: ",
                fontSize: 14.sp,
                color: Colors.black45,
              ),
              10.wt,
              secondaryText(
                text: "(${widget.aOrders.toString()}) orders",
                fontSize: 12.sp,
              ),
            ],
          ),
          15.ht,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.edit_outlined, color: AppColors.primaryColor),
              15.wt,
              GestureDetector(
                onTap: () async {
                  await _adsController.deleteAds(ref, widget.adsId);
                },
                child: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
