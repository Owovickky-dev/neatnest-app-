import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/controller/state%20controller%20/booking/booking_state_controller.dart';
import 'package:neat_nest/screens/booking/widgets/group_booking_data.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_confirmation_button.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../../models/booking_model.dart';
import '../../../../../utilities/constant/colors.dart';
import '../../../../../utilities/constant/extension.dart';
import '../../../../../widget/loading_screen.dart';
import '../../../../history/utilities/data_screen.dart';
import '../../../model/booking_data_model.dart';

class BookingDataBuilder extends ConsumerStatefulWidget {
  const BookingDataBuilder({
    super.key,
    required this.topText,
    required this.title,
    required this.status,
    required this.functionLeft,
    this.functionRight,
  });

  final String topText;
  final String title;
  final BookingStatus status;

  final void Function(String bookingId, String bookingStatus, String userRole)
  functionLeft;
  final void Function(String bookingId, String bookingStatus, String userRole)?
  functionRight;

  @override
  ConsumerState<BookingDataBuilder> createState() => _BookingDataBuilderState();
}

class _BookingDataBuilderState extends ConsumerState<BookingDataBuilder> {
  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(bookingStateControllerProvider);

    List<BookingModel> getBookingList(
      GroupedBookings booking,
      BookingStatus status,
    ) {
      switch (status) {
        case BookingStatus.awaitingAction:
          return booking.awaitingAction;

        case BookingStatus.completed:
          return booking.completed;

        case BookingStatus.active:
          return booking.active;

        case BookingStatus.closed:
          return booking.closed;

        case BookingStatus.disputed:
          return booking.disputed;
      }
    }

    return Scaffold(
      appBar: AppBarHolder(title: widget.title),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.ht,

            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.comment,
                  color: AppColors.primaryColor,
                  size: 20.r,
                ),
                10.wt,
                secondaryText(text: widget.topText, fontSize: 16.sp),
              ],
            ),
            20.ht,
            Expanded(
              child: bookings.when(
                loading: () => const LoadingScreen(),
                error: (err, st) => Center(child: Text("Error: $err")),
                data: (booking) {
                  final userBookings = getBookingList(booking, widget.status);
                  return userBookings.isEmpty
                      ? Center(
                          child: primaryText(
                            text: "No Any Booking match this category found",
                            textAlign: TextAlign.center,
                            fontSize: 25.sp,
                          ),
                        )
                      : ListView.builder(
                          itemCount: userBookings.length,
                          itemBuilder: (context, index) {
                            final userBooking = userBookings[index];
                            final buttonConfig = userBooking
                                .status!
                                .toBookingStatus
                                .buttonConfig(userBooking.role!);

                            return DataScreen(
                              event: userBooking.event!,
                              leftButtonText: buttonConfig.leftText,
                              preferredDate: userBooking.preferredDate!,
                              rightButtonText: buttonConfig.rightText,
                              serviceName: userBooking.title!,
                              serviceProvider: userBooking.providerUserName!,
                              imagePath: userBooking.imageUrl!,
                              price: userBooking.price!,
                              bookingStatus: userBooking.status!,
                              sender: userBooking.bookerUserName,
                              userRole: userBooking.role!,
                              functionLeft: () => appConfirmationButton(
                                context: context,
                                title: widget.title,
                                subTitle:
                                    "Are you sure you want to perform this action",
                                textButtonTextLeft: "No",
                                textButtonTextRight: "Yes",
                                functionRight: () => widget.functionLeft(
                                  userBooking.bookingId!,
                                  userBooking.status!,
                                  userBooking.role!,
                                ),
                              ),
                              functionRight: () => appConfirmationButton(
                                context: context,
                                title: widget.title,
                                subTitle:
                                    "Are you sure you want to perform this action",
                                textButtonTextLeft: "No",
                                textButtonTextRight: "Yes",
                                functionRight: () => widget.functionRight?.call(
                                  userBooking.bookingId!,
                                  userBooking.status!,
                                  userBooking.role!,
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
