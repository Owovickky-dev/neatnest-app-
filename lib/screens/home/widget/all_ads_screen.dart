import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/query_data_controller.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../utilities/constant/colors.dart';
import '../../../widget/app_text.dart';
import '../../favorite/utilities/favourite_data_holder.dart';
import '../notifier/home_display_data_state.dart';

class AllAdsScreen extends ConsumerStatefulWidget {
  const AllAdsScreen({super.key, this.yesBackButton = true});

  final bool yesBackButton;

  @override
  ConsumerState<AllAdsScreen> createState() => _AllAdsScreenState();
}

class _AllAdsScreenState extends ConsumerState<AllAdsScreen> {
  bool _initialLoad = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAds());
  }

  void _loadAds() {
    if (!_initialLoad) {
      ref.read(queryDataControllerProvider.notifier).getAdsData();
      _initialLoad = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final adsData = ref.watch(queryDataControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: adsData.when(
              loading: () {
                print("Loading screen first");
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: FittedBox(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: AppColors.primaryColor,
                            strokeWidth: 6,
                          ),
                        ),
                      ),
                      20.ht,
                      primaryText(text: "loading........"),
                    ],
                  ),
                );
              },
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error loading ads: $error'),
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(queryDataControllerProvider.notifier)
                            .getAdsData();
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (ads) {
                return GridView.builder(
                  itemCount: ads.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 20.h,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    final ad = ads[index];
                    return FavouriteDataHolder(index: index, adsModel: ad);
                  },
                );
              },
            ),
          ),
          10.ht,
          widget.yesBackButton
              ? GestureDetector(
                  onTap: () {
                    ref
                        .read(homeDisplayDataStateProvider.notifier)
                        .displayData(false);
                  },
                  child: Container(
                    height: 30.h,
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.black12,
                      // color: AppColors.primaryColor.withValues(
                      //   alpha: 0.5,
                      // ),
                    ),
                    child: Center(
                      child: primaryText(
                        text: "Back to main page",
                        textAlign: TextAlign.center,
                        color: AppColors.blackTextColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
