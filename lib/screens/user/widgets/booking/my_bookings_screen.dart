import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/booking/widgets/group_booking_data.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';

import '../../../../utilities/constant/extension.dart';
import '../../../../widget/app_text.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: "My Bookings"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.ht,
              Row(
                children: [
                  Icon(Icons.reorder, color: Colors.grey, size: 30.sp),
                  10.wt,
                  secondaryText(text: "All about booking", fontSize: 18.sp),
                ],
              ),
              30.ht,
              GroupBookingData(),
            ],
          ),
        ),
      ),
    );
  }
}
