import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/screens/booking/notifiers/rooms_count_state.dart';
import 'package:neat_nest/screens/history/utilities/app_bar_icon.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class SelectRoomsContainer extends ConsumerWidget {
  const SelectRoomsContainer({super.key, required this.index});

  final int index;

  final List<dynamic> icons = const [
    Icons.chair,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.plateWheat,
    FontAwesomeIcons.shower,
    FontAwesomeIcons.kitchenSet,
  ];

  final List<String> itemNames = const [
    "Living Room",
    "Bed Room",
    "Dining Rooms",
    "Bathroom",
    "Kitchen",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomNumberCount = ref.watch(roomsCountStateProvider(index));
    final readRoomCount = ref.read(roomsCountStateProvider(index).notifier);
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(color: AppColors.containerLightBackground),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppBarIcon(
                height: 50.h,
                width: 50.w,
                radius: 25.r,
                icons: icons[index],
                function: () {},
                iconColor: AppColors.primaryColor,
                bckColor: AppColors.primaryColor.withValues(alpha: 0.09),
              ),
              5.wt,
              primaryText(text: itemNames[index], fontSize: 15.sp),
            ],
          ),
          Row(
            children: [
              AppBarIcon(
                height: 30.h,
                width: 30.w,
                radius: 15.r,
                icons: Icons.remove,
                function: () {
                  readRoomCount.decreasement();
                },
                bckColor: Colors.grey.withValues(alpha: 0.15),
              ),
              10.wt,
              primaryText(text: roomNumberCount.toString()),
              10.wt,
              AppBarIcon(
                height: 30.h,
                width: 30.w,
                radius: 15.r,
                icons: Icons.add,
                function: () {
                  readRoomCount.increasement();
                },
                bckColor: AppColors.primaryColor,
                iconColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
