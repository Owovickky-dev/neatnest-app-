import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/user_ads_state_controller.dart';
import 'package:neat_nest/screens/user/ads/utilities/view_ads_template.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
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
    ref.read(userAdsStateControllerProvider.notifier).getUserAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myAds = ref.watch(userAdsStateControllerProvider);
    final totalAds = myAds?.totalAds;
    final activeAds = myAds?.activeAds;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'My Ads'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: myAds != null
              ? Column(
                  children: [
                    20.ht,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        secondaryText(
                          text: "Active Ads   (${activeAds?.length})",
                        ),
                        secondaryText(text: "Total Ads  (${totalAds?.length})"),
                      ],
                    ),
                    20.ht,
                    Expanded(
                      child: ListView.builder(
                        itemCount: totalAds?.length,
                        itemBuilder: (context, index) {
                          final allAds = totalAds?[index];
                          return ViewAdsTemplate(
                            title: allAds!.title!,
                            category: allAds.category!,
                            basePrice: allAds.basePrice!,
                            aOrders: 4,
                          );
                        },
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
