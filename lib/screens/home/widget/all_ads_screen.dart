import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/ads_state_controller.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/loading_screen.dart';

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
      ref.read(adsStateControllerProvider.notifier).getAllAds();
      _initialLoad = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final adsData = ref.watch(adsStateControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: adsData.isNotEmpty
                ? GridView.builder(
                    itemCount: adsData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 20.h,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      final ad = adsData[index];
                      return FavouriteDataHolder(index: index, adsModel: ad);
                    },
                  )
                : LoadingScreen(),
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
