import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/query_ads_state.dart';
import 'package:neat_nest/screens/home/filter/notifier/filter_state.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../models/ads_model.dart';
import '../../../../widget/app_bar_holder.dart';
import '../../../../widget/loading_screen.dart';
import '../../../favorite/utilities/favourite_data_holder.dart';

class FilterResultScreen extends ConsumerStatefulWidget {
  const FilterResultScreen({super.key});

  @override
  ConsumerState<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends ConsumerState<FilterResultScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncAdsData = ref.watch(queryAdsStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Filter Result'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(children: [Expanded(child: _buildContent(asyncAdsData))]),
      ),
    );
  }

  Widget _buildContent(AsyncValue<List<AdsModel>> asyncAdsData) {
    return asyncAdsData.when(
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
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
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
          ElevatedButton(
            onPressed: () {
              ref.read(filterStateProvider.notifier).reset();
              AppNavigatorHelper.pushReplacement(context, AppRoute.filterData);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
            ),
            child: primaryText(
              text: "Adjust Filters",
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
