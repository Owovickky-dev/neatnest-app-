import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/ads_controller.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

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
    required this.userCountry,
    required this.userState,
    required this.image,
    required this.isActive,
    required this.about,
  });

  final String title;
  final String category;
  final num basePrice;
  final num aOrders;
  final String adsId;
  final AdsController? controller;
  final String userCountry;
  final String userState;
  final bool isActive;
  final String about;
  final String image;

  @override
  ConsumerState<ViewAdsTemplate> createState() => _ViewAdsTemplateState();
}

class _ViewAdsTemplateState extends ConsumerState<ViewAdsTemplate> {
  final AdsController _adsController = AdsController();

  void showConfirmationDialog({bool? activate}) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: primaryText(
            text: activate == null
                ? "Delete Ads"
                : widget.isActive
                ? "Deactivate Ads"
                : "Activate Ads",
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              secondaryText(
                text: activate == null
                    ? "Are you sure you want to delete this Ads?"
                    : widget.isActive
                    ? "You are making the Ads Inactive, no user will see the ads"
                    : "You are making the Ads Active,  users can now see the ads",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                dialogContext.pop();
              },
              child: secondaryText(text: "Cancel"),
            ),
            TextButton(
              onPressed: () async {
                dialogContext.pop();
                if (activate == null) {
                  await _adsController.deleteAds(ref, widget.adsId);
                } else {
                  await _adsController.activate(
                    context,
                    !widget.isActive,
                    ref,
                    widget.adsId,
                  );
                }
              },
              child: secondaryText(
                text: activate == null
                    ? "Yes Delete"
                    : activate
                    ? "Yes Deactivate"
                    : "Yes Activate",
              ),
            ),
          ],
        );
      },
    );
  }

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
            children: [
              primaryText(
                text: "Ads Active: ",
                fontSize: 14.sp,
                color: Colors.black45,
              ),
              10.wt,
              Container(
                height: 20.h,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.white,
                ),
                child: GestureDetector(
                  onTap: () =>
                      showConfirmationDialog(activate: widget.isActive),
                  child: Row(
                    mainAxisAlignment: widget.isActive
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 18.h,
                        width: 18.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.r),
                          color: widget.isActive
                              ? AppColors.primaryColor
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          15.ht,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.isActive == true) {
                    showErrorNotification(
                      message:
                          "Active Ads cant be update, please kindly deactivate the ads",
                    );
                  } else {
                    final adsData = AdsModel(
                      title: widget.title,
                      category: widget.category,
                      basePrice: widget.basePrice,
                      id: widget.adsId,
                      country: widget.userCountry,
                      state: widget.userState,
                      about: widget.about,
                      isActive: widget.isActive,
                      image: widget.image,
                    );

                    AppNavigatorHelper.push(
                      context,
                      AppRoute.postAdsScreen,
                      extra: adsData,
                    );
                  }
                },
                child: Icon(Icons.edit_outlined, color: AppColors.primaryColor),
              ),
              15.wt,
              GestureDetector(
                onTap: showConfirmationDialog,
                child: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
