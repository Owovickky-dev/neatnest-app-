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
  const AllAdsScreen({super.key});

  @override
  ConsumerState<AllAdsScreen> createState() => _AllAdsScreenState();
}

class _AllAdsScreenState extends ConsumerState<AllAdsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(queryDataControllerProvider.notifier).getAdsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final adsData = ref.watch(queryDataControllerProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 3,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                return FavouriteDataHolder(index: index);
              },
            ),
          ),
          10.ht,
          GestureDetector(
            onTap: () {
              ref
                  .read(homeDisplayDataStateProvider.notifier)
                  .displayData(false);

              print("The avablae ads lenght is, ${adsData.value?.length}");
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
          ),
        ],
      ),
    );
  }
}
