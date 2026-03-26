import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/booking_form_controller.dart';
import 'package:neat_nest/screens/booking/notifiers/booking_time_state.dart';
import 'package:neat_nest/screens/booking/widgets/booking_text_field.dart';
import 'package:neat_nest/screens/history/utilities/app_bar_icon.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/capitalize_first_character.dart';

import '../../../controller/state controller /ads/ads_state_controller.dart';
import '../../../utilities/constant/colors.dart';
import '../../../widget/app_text.dart';
import '../../history/utilities/text_filed_holder.dart';

class BookingFormScreen extends ConsumerStatefulWidget {
  const BookingFormScreen({super.key, required this.index, required this.isMe});

  final int index;
  final bool isMe;

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  late BookingFormController _bookingFormController;

  late List<String>? times = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bookingFormController = BookingFormController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bookingTime = ref.watch(bookingTimeStateProvider);
    final adsInfo = ref.watch(adsStateControllerProvider)[widget.index];
    final myAvailable = ref.watch(adsStateControllerProvider);
    times = myAvailable[widget.index].availableTime!;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: primaryText(text: "Booking Form"),
          leading: AppBarIcon(
            icons: Icons.arrow_back_ios,
            function: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ht,
              primaryText(text: "Service Details:", fontSize: 17.sp),
              10.ht,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        primaryText(text: "Service Title: ", fontSize: 13.sp),
                        5.wt,
                        secondaryText(
                          text: capitalizeFirstCharacter(adsInfo.title!),
                        ),
                      ],
                    ),
                    5.ht,
                    Row(
                      children: [
                        primaryText(text: "Service Poster: ", fontSize: 13.sp),
                        5.wt,
                        secondaryText(
                          text: capitalizeFirstCharacter(
                            adsInfo.jobPoster!.username,
                          ),
                        ),
                      ],
                    ),
                    5.ht,
                    Row(
                      children: [
                        primaryText(
                          text: "Service Category: ",
                          fontSize: 13.sp,
                        ),
                        5.wt,
                        secondaryText(
                          text: capitalizeFirstCharacter(adsInfo.category!),
                        ),
                      ],
                    ),
                    5.ht,
                    Row(
                      children: [
                        primaryText(
                          text: "Service BasePrice: ",
                          fontSize: 13.sp,
                        ),
                        5.wt,
                        secondaryText(
                          text: "\$${adsInfo.basePrice.toString()} / hour",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              20.ht,
              DottedLine(dashColor: AppColors.primaryColor),
              10.ht,
              primaryText(text: "Service For:", fontSize: 17.sp),
              10.ht,
              BookingTextField(
                titleText: "Name",
                hintText: "Enter name",
                textEditingController:
                    _bookingFormController.bookingNameController,
              ),
              20.ht,
              BookingTextField(
                titleText: "Email Address",
                hintText: "Enter email Address",
                textEditingController:
                    _bookingFormController.bookingEmailController,
              ),
              20.ht,
              BookingTextField(
                titleText: "Enter Address",
                hintText: "Enter User Address",
                textEditingController:
                    _bookingFormController.bookingUserAddress,
              ),
              20.ht,
              primaryText(text: "Worker Available  Date", fontSize: 15.sp),
              10.ht,
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: AppColors.containerLightBackground,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: DropdownButton(
                  hint: secondaryText(text: "Select Time"),
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                  isExpanded: true,
                  value: bookingTime.isEmpty ? null : bookingTime,
                  underline: SizedBox(),
                  items: times?.map((time) {
                    return DropdownMenuItem(
                      value: time,
                      child: secondaryText(text: time),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      ref
                          .read(bookingTimeStateProvider.notifier)
                          .timePicked(value);
                    }
                  },
                ),
              ),
              20.ht,
              TextFiledHolder(
                titleText: 'Work Details',
                containerHeight: 150.h,
                hintText: 'Add Details...',
                textAlign: TextAlign.start,
                controller: _bookingFormController.bookingNoteController,
              ),
              20.ht,
              AppButton(
                text: "Continue",
                fontSize: 20.sp,
                width: double.infinity,
                bckColor: AppColors.primaryColor,
                textColor: Colors.white,
                function: () {
                  _bookingFormController.onSubmit(ref, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
