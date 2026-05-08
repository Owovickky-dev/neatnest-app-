import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/screens/user/model/booking_data_model.dart';
import 'package:neat_nest/screens/user/widgets/row_data_holder.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';

import '../../../../utilities/constant/extension.dart';
import '../../../../utilities/route/app_naviation_helper.dart';
import '../../../../utilities/route/app_route_names.dart';
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
              RowDataHolder(
                text: "Completed",
                icons: FontAwesomeIcons.checkDouble,
                function: () {
                  AppNavigatorHelper.push(
                    context,
                    AppRoute.bookingDataBuilder,
                    extra: BookingDataModel(
                      leftText: "Leave Review",
                      rightText: "E-Receipt",
                      topText: "Completed Orders",
                      title: "Completed Booking",
                      status: BookingStatus.completed,
                      functionLeft: (bookingId) {
                        print(
                          "The Booking ID of this left clicked is $bookingId",
                        );
                      },
                      functionRight: (bookingId) {
                        print(
                          "The Booking ID of this right clicked is $bookingId",
                        );
                      },
                    ),
                  );
                },
              ),
              30.ht,
              RowDataHolder(
                text: "Ongoing Order",
                icons: FontAwesomeIcons.hourglassHalf,
                function: () {
                  AppNavigatorHelper.push(
                    context,
                    AppRoute.bookingDataBuilder,
                    extra: BookingDataModel(
                      leftText: "Terminate",
                      rightText: "E-Receipt",
                      topText: "Ongoing Order",
                      title: "Ongoing Order",
                      status: BookingStatus.ongoing,
                      functionLeft: (bookingId) {
                        print(
                          "The Booking ID of this left clicked is $bookingId",
                        );
                      },
                      functionRight: (bookingId) {
                        print(
                          "The Booking ID of this right clicked is $bookingId",
                        );
                      },
                    ),
                  );
                },
              ),
              30.ht,
              RowDataHolder(
                text: "Awaiting_Confirmation",
                icons: FontAwesomeIcons.spinner,
                function: () {
                  AppNavigatorHelper.push(
                    context,
                    AppRoute.bookingDataBuilder,
                    extra: BookingDataModel(
                      leftText: "Accept",
                      rightText: "Reject",
                      topText: "Awaiting your  Confirmation",
                      title: "Confirmed Order",
                      status: BookingStatus.awaitingAction,
                      functionLeft: (bookingId) {
                        print(
                          "The Booking ID of this left clicked is $bookingId",
                        );
                      },
                      functionRight: (bookingId) {
                        print(
                          "The Booking ID of this right clicked is $bookingId",
                        );
                      },
                    ),
                  );
                },
              ),
              30.ht,
              RowDataHolder(
                text: "Cancel",
                icons: FontAwesomeIcons.circleMinus,
                function: () {
                  AppNavigatorHelper.push(
                    context,
                    AppRoute.bookingDataBuilder,
                    extra: BookingDataModel(
                      leftText: "Cancel",
                      rightText: "E-Receipt",
                      topText: "Cancelled Orders",
                      title: "Cancelled Booking",
                      status: BookingStatus.cancelled,
                      functionLeft: (bookingId) {
                        print(
                          "The Booking ID of this left clicked is $bookingId",
                        );
                      },
                      functionRight: (bookingId) {
                        print(
                          "The Booking ID of this right clicked is $bookingId",
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
