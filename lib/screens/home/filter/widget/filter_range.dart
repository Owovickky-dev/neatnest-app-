import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/home/filter/notifier/filter_state.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterRange extends ConsumerWidget {
  const FilterRange({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterStateProvider);

    final double minPrice = filterState?.minPrice ?? 50;
    final double maxPrice = filterState?.maxPrice ?? 1000;
    return Column(
      children: [
        SfRangeSlider(
          min: 50,
          max: 1000,
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.secondaryTextColor.withValues(alpha: 0.3),
          values: SfRangeValues(minPrice, maxPrice),
          showTicks: false,
          enableTooltip: false,
          showLabels: false,
          onChanged: (SfRangeValues newValue) {
            ref.read(filterStateProvider.notifier).setMinPrice(newValue.start);
            ref.read(filterStateProvider.notifier).setMaxPrice(newValue.end);
          },
        ),
        10.ht,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
              width: MediaQuery.of(context).size.width * 0.43,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.containerLightBackground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  secondaryText(text: "Minimum Price", fontSize: 12.sp),
                  5.ht,
                  primaryText(
                    text: "\$ ${minPrice.round()}.00",
                    fontSize: 17.sp,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
              width: MediaQuery.of(context).size.width * 0.43,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.containerLightBackground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  secondaryText(text: "Maximum Price", fontSize: 12.sp),
                  5.ht,
                  primaryText(
                    text: "\$ ${maxPrice.round()}.00",
                    fontSize: 17.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
