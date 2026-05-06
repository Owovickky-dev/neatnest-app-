import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/controller/state%20controller%20/booking/booking_state_controller.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../../models/booking_model.dart';
import '../../../../../utilities/constant/colors.dart';
import '../../../../../utilities/constant/extension.dart';
import '../../../../../widget/loading_screen.dart';
import '../../../../history/utilities/data_screen.dart';
import '../../../../history/widget /electronic_reciept_screen.dart';
import '../../../model/booking_data_model.dart';

class BookingDataBuilder extends ConsumerStatefulWidget {
  const BookingDataBuilder({
    super.key,
    required this.leftText,
    required this.rightText,
    required this.topText,
    required this.title,
    required this.status,
  });

  final String leftText;
  final String rightText;
  final String topText;
  final String title;
  final BookingStatus status;

  @override
  ConsumerState<BookingDataBuilder> createState() => _BookingDataBuilderState();
}

class _BookingDataBuilderState extends ConsumerState<BookingDataBuilder> {
  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(bookingStateControllerProvider);

    // This help in the sorting based on the booking status
    List<BookingModel> getBookingList(
      GroupedBookings booking,
      BookingStatus status,
    ) {
      switch (status) {
        case BookingStatus.awaitingConfirmation:
          return booking.awaitingConfirmation;

        case BookingStatus.completed:
          return booking.completed;

        case BookingStatus.ongoing:
          return booking.ongoing;

        case BookingStatus.cancelled:
          return booking.cancelled;
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
                  return SizedBox(
                    child: userBookings.isEmpty
                        ? Center(
                            child: primaryText(text: "No Any Booking found"),
                          )
                        : ListView.builder(
                            itemCount: userBookings.length,
                            itemBuilder: (context, index) {
                              final userBooking = userBookings[index];
                              return DataScreen(
                                text1: widget.leftText,
                                preferredDate: userBooking.preferredDate!,
                                text2: widget.rightText,
                                serviceName: userBooking.title!,
                                serviceProvider: userBooking.providerUserName!,
                                imagePath: userBooking.imageUrl!,
                                price: userBooking.price!,
                                sender: userBooking.bookerUserName,
                                function1: () {
                                  debugPrint(
                                    'The Cancel text is clicked of index: $index',
                                  );
                                },
                                function2: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ElectronicReceiptScreen(index: index),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
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
