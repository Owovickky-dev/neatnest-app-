import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/ads_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/user_ads_state_controller.dart';
import 'package:neat_nest/screens/user/ads/utilities/view_ads_template.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../../../../widget/app_bar_holder.dart';

class ViewAdsScreen extends ConsumerStatefulWidget {
  const ViewAdsScreen({super.key});

  @override
  ConsumerState<ViewAdsScreen> createState() => _ViewAdsScreenState();
}

class _ViewAdsScreenState extends ConsumerState<ViewAdsScreen> {
  AdsController controller = AdsController();
  bool isLoading = true;
  bool isActive = true;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    await controller.getUserAds(context, ref);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final myAds = ref.watch(userAdsStateControllerProvider);
    final activeAds = myAds?.activeAds;
    final totalAds = myAds?.totalAds;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(
        title: 'My Ads',
        function: () {
          context.pop();
        },
      ),
      body: isLoading
          ? LoadingScreen()
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: totalAds!.isNotEmpty
                    ? Column(
                        children: [
                          20.ht,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isActive = true;
                                  });
                                },
                                child: secondaryText(
                                  text: "Active Ads   (${activeAds?.length})",
                                  fontSize: 16.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isActive = false;
                                  });
                                },
                                child: secondaryText(
                                  text: "Total Ads  (${totalAds.length})",
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          20.ht,
                          isActive
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount: activeAds?.length,
                                    itemBuilder: (context, index) {
                                      final activeAd = activeAds?[index];
                                      return ViewAdsTemplate(
                                        title: activeAd!.title!,
                                        category: activeAd.category!,
                                        basePrice: activeAd.basePrice!,
                                        adsId: activeAd.id!,
                                        aOrders: 4,
                                        userCountry: activeAd.country!,
                                        userState: activeAd.state!,
                                        image: activeAd.imageFrmServer!,
                                        isActive: activeAd.isActive!,
                                        about: activeAd.about!,
                                      );
                                    },
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: totalAds.length,
                                    itemBuilder: (context, index) {
                                      final allAds = totalAds[index];
                                      return ViewAdsTemplate(
                                        title: allAds.title!,
                                        category: allAds.category!,
                                        basePrice: allAds.basePrice!,
                                        adsId: allAds.id!,
                                        aOrders: 4,
                                        userCountry: allAds.country!,
                                        userState: allAds.state!,
                                        image: allAds.imageFrmServer!,
                                        isActive: allAds.isActive!,
                                        about: allAds.about!,
                                      );
                                    },
                                  ),
                                ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: primaryText(text: "You have no ads Yet!!!"),
                          ),
                          10.ht,
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              AppNavigatorHelper.push(
                                context,
                                AppRoute.postAdsScreen,
                              );
                            },
                            child: secondaryText(
                              text: "Post Ad",
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
    );
  }
}
