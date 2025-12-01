import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/query_ads_state.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../../../utilities/constant/colors.dart';
import '../../../widget/app_text.dart';
import '../../favorite/utilities/favourite_data_holder.dart';
import '../notifier/home_display_data_state.dart';

class SearchingScreen extends ConsumerStatefulWidget {
  const SearchingScreen({super.key, this.yesBackButton = true});

  final bool yesBackButton;

  @override
  ConsumerState<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends ConsumerState<SearchingScreen> {
  @override
  Widget build(BuildContext context) {
    final adsData = ref.watch(queryAdsStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: adsData.when(
              loading: () => LoadingScreen(),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 80.w, color: Colors.red),
                    20.ht,
                    primaryText(text: "Failed to load ads", color: Colors.red),
                    10.ht,
                    secondaryText(text: "Please try again"),
                    30.ht,
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 15.h,
                        ),
                      ),
                      child: primaryText(
                        text: "Go Back",
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              data: (adsData) {
                if (adsData.isEmpty) {
                  return _buildEmptyState();
                }

                return GridView.builder(
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
                );
              },
            ),
          ),
          10.ht,
          ?widget.yesBackButton
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
              : null,
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80.w, color: Colors.grey[400]),
          20.ht,
          primaryText(text: "No Ads Match Your Filter", color: Colors.grey),
          SizedBox(height: 10.h),
          secondaryText(text: "Try adjusting your filters to see more results"),
          30.ht,
        ],
      ),
    );
  }
}
