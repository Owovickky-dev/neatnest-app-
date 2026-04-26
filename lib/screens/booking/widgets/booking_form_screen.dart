import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/controller/booking_form_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/popular_service_controller.dart';
import 'package:neat_nest/screens/booking/widgets/booking_text_field.dart';
import 'package:neat_nest/screens/history/utilities/app_bar_icon.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/capitalize_first_character.dart';

import '../../../controller/state controller /address/address_state_controller.dart';
import '../../../controller/state controller /ads/ads_state_controller.dart';
import '../../../controller/state controller /user/user_controller_state.dart';
import '../../../utilities/constant/colors.dart';
import '../../../widget/app_text.dart';
import '../../history/utilities/text_filed_holder.dart';

class BookingFormScreen extends ConsumerStatefulWidget {
  const BookingFormScreen({
    super.key,
    required this.index,
    required this.isMe,
    required this.isPopularAds,
  });

  final int index;
  final bool isMe;
  final bool isPopularAds;

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  late BookingFormController _bookingFormController;

  List<String> workerTimes = [];
  String? selectedDate;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    _bookingFormController = BookingFormController();
    if (widget.isMe) {
      prefiledData();
    }
  }

  void prefiledData() {
    final userData = ref.read(userControllerStateProvider);
    final userAddressData = ref.read(addressStateControllerProvider)[0];

    _bookingFormController.bookingNameController.text = userData!.name;
    _bookingFormController.bookingEmailController.text = userData.email;
    _bookingFormController.bookingUserNos.text = userData.phoneNumber.isEmpty
        ? " "
        : userData.phoneNumber;

    if (userAddressData.state!.isNotEmpty &&
        userAddressData.country!.isNotEmpty &&
        userAddressData.address!.isNotEmpty) {
      _bookingFormController.bookingUserAddress.text =
          "${userAddressData.address}, ${userAddressData.state}, ${userAddressData.country}";
    } else {
      _bookingFormController.bookingUserAddress.text = " ";
    }
  }

  @override
  Widget build(BuildContext context) {
    final popularAds = ref.watch(popularServiceControllerProvider);
    final generalAds = ref.watch(adsStateControllerProvider);
    final ads = widget.isPopularAds ? popularAds : generalAds;
    final adsInfo = ads[widget.index];
    final myAvailable = adsInfo.availableSchedule ?? [];
    final dates = myAvailable.map((date) {
      final formattedDate = DateTime.parse(date.workerAvailableDates).toLocal();
      final dates = DateFormat('dd/MM/yyyy').format(formattedDate);
      return dates;
    }).toList();

    if (selectedDate != null) {
      final selected = myAvailable.firstWhere((item) {
        final formatted = DateFormat(
          'dd/MM/yyyy',
        ).format(DateTime.parse(item.workerAvailableDates).toLocal());
        return formatted == selectedDate;
      });
      workerTimes = selected.workerAvailableTimes.map((e) => e.time).toList();
    }
    _bookingFormController.serviceId = adsInfo.id;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: primaryText(text: "Booking Form"),
          leading: AppBarIcon(
            icons: Icons.arrow_back,
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
                        primaryText(text: "Service Title: ", fontSize: 15.sp),
                        5.wt,
                        secondaryText(
                          text: capitalizeFirstCharacter(adsInfo.title!),
                          fontSize: 15.sp,
                        ),
                      ],
                    ),
                    5.ht,
                    Row(
                      children: [
                        primaryText(text: "Service Poster: ", fontSize: 15.sp),
                        5.wt,
                        secondaryText(
                          text: capitalizeFirstCharacter(
                            adsInfo.jobPoster!.username,
                          ),
                          fontSize: 15.sp,
                        ),
                      ],
                    ),
                    5.ht,
                    Row(
                      children: [
                        primaryText(
                          text: "Service Category: ",
                          fontSize: 15.sp,
                        ),
                        5.wt,
                        secondaryText(
                          text: capitalizeFirstCharacter(adsInfo.category!),
                          fontSize: 15.sp,
                        ),
                      ],
                    ),
                    5.ht,
                    Row(
                      children: [
                        primaryText(
                          text: "Service BasePrice: ",
                          fontSize: 15.sp,
                        ),
                        5.wt,
                        secondaryText(
                          text: "\$${adsInfo.basePrice.toString()} / hour",
                          fontSize: 15.sp,
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
                titleText: "Phone Number",
                hintText: "Enter email Address",
                textEditingController: _bookingFormController.bookingUserNos,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9()+\-\s]')),
                  LengthLimitingTextInputFormatter(20),
                ],
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
                titleText: "Enter Address (Address, State, Country)",
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
                  hint: secondaryText(
                    text: myAvailable.isEmpty
                        ? "No date available yet"
                        : "Select Date",
                  ),
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                  isExpanded: true,
                  value: selectedDate,
                  underline: SizedBox(),
                  items: dates.map((date) {
                    return DropdownMenuItem<String>(
                      value: date,
                      child: secondaryText(text: date),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDate = value;
                      _bookingFormController.preferredDate = value;
                      selectedTime = null;
                    });
                  },
                ),
              ),
              10.ht,
              primaryText(text: "Worker Available  Time", fontSize: 15.sp),
              10.ht,
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: AppColors.containerLightBackground,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: DropdownButton(
                  hint: secondaryText(
                    text: workerTimes.isEmpty
                        ? "No time available yet"
                        : "Select Time",
                  ),
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                  isExpanded: true,
                  value: selectedTime,
                  underline: SizedBox(),
                  items: workerTimes.map((time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: secondaryText(text: time),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTime = value;
                      _bookingFormController.preferredTime = value;
                    });
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
