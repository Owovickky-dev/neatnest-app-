import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  @override
  void initState() {
    super.initState();

    ref.read(userAdsStateControllerProvider.notifier).getUserAds();
  }

  @override
  Widget build(BuildContext context) {
    final myAds = ref.watch(userAdsStateControllerProvider);
    final activeAds = myAds?.activeAds;
    final totalAds = myAds?.totalAds;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'My Ads'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: myAds != null
              ? totalAds!.isNotEmpty
                    ? Column(
                        children: [
                          20.ht,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              secondaryText(
                                text: "Active Ads   (${activeAds?.length})",
                              ),
                              secondaryText(
                                text: "Total Ads  (${totalAds.length})",
                              ),
                            ],
                          ),
                          20.ht,
                          Expanded(
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
                      )
              : LoadingScreen(),
        ),
      ),
    );
  }
}
