import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/controller/ads_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/address/address_state_controller.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/screens/user/model/user_location_model.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/image_upload_helper.dart';
import 'package:neat_nest/widget/multiple_select_image.dart';

import '../../../../controller/state controller /user/user_controller_state.dart';
import '../../../../widget/app_bar_holder.dart';
import '../../../../widget/app_notification.dart';
import '../../../history/utilities/text_filed_holder.dart';
import '../../utilities/auth_text_filed.dart';

class PostAdsScreen extends ConsumerStatefulWidget {
  const PostAdsScreen({super.key, this.adsData});

  final AdsModel? adsData;

  @override
  ConsumerState<PostAdsScreen> createState() => _PostAdsScreenState();
}

class _PostAdsScreenState extends ConsumerState<PostAdsScreen> {
  late AdsController _adsController;
  UserLocationModel? userLocationModel;

  final _formKey = GlobalKey<FormState>();

  Map<DateTime, List<String>> selectedDateTimes = {};
  List<String> categories = [];
  List<String> timeSlots = [
    "1:00AM",
    "1:00PM",
    "2:00AM",
    "2:00PM",
    "3:00AM",
    "3:00PM",
    "4:00AM",
    "4:00PM",
    "5:00AM",
    "5:00PM",
    "6:00AM",
    "6:00PM",
    "7:00AM",
    "7:00PM",
    "8:00AM",
    "8:00PM",
    "9:00AM",
    "9:00PM",
    "10:00AM",
    "10:00PM",
    "11:00AM",
    "11:00PM",
    "12:00AM",
    "12:00PM",
  ];

  final List<String> status = ["True", "False"];
  late List<DateTime?> _date = [];
  final List<String> selectedTimes = [];

  bool isOpen = false;
  int _currentTitleTextLength = 0;

  List<WorkerAvailableInfoModel> workerAvailableTime = [];
  String? categorySelected;
  String? statusSelected;
  UserLocationModel? selectedAddress;

  @override
  void initState() {
    super.initState();
    _adsController = AdsController();

    if (widget.adsData != null && mounted) {
      _adsController.id = widget.adsData?.id;
      prefilledData();
    }
  }

  void prefilledData() {
    final myAds = widget.adsData!;
    _adsController.adsAboutController.text = myAds.about!;
    _adsController.adsPriceController.text = myAds.basePrice!.toString();
    _adsController.adsTitleController.text = myAds.title!;
    String category =
        myAds.category![0].toUpperCase() +
        myAds.category!.substring(1).toLowerCase();
    String status = myAds.isActive! ? "True" : "False";
    setState(() {
      categorySelected = category;
      statusSelected = status;
    });
  }

  Future<List<String>?> _showTimePickerDialog(DateTime date) async {
    List<String> tempSelectedTimes = List.from(selectedDateTimes[date] ?? []);

    return showDialog<List<String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(
                "Select time for ${date.day}/${date.month}/${date.year}",
              ),

              content: SizedBox(
                width: double.maxFinite,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: timeSlots.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    final time = timeSlots[index];
                    final isSelected = tempSelectedTimes.contains(time);
                    return GestureDetector(
                      onTap: () {
                        setStateDialog(() {
                          if (isSelected) {
                            tempSelectedTimes.remove(time);
                          } else {
                            tempSelectedTimes.add(time);
                          }
                        });
                      },

                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.green
                              : Colors.grey.shade200,

                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),

                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: tempSelectedTimes.isEmpty
                      ? null
                      : () => Navigator.pop(context, tempSelectedTimes),

                  child: const Text("Done"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void buildSchedule() {
    final sortedEntries = selectedDateTimes.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    workerAvailableTime = sortedEntries.map((entry) {
      final date = entry.key.toLocal();
      final times = entry.value;

      return WorkerAvailableInfoModel(
        workerAvailableDates: DateFormat('dd/MM/yyyy').format(date),
        workerAvailableTimes: times
            .map((t) => WorkerAvailableTime(time: t))
            .toList(),
      );
    }).toList();

    _adsController.timeAvailable = workerAvailableTime;
  }

  void _showAddressBottomSheet(List<UserLocationModel> userAddresses) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              20.ht,
              primaryText(text: "Select Address", fontSize: 20.sp),
              15.ht,
              Expanded(
                child: ListView.builder(
                  itemCount: userAddresses.length,
                  itemBuilder: (context, index) {
                    final address = userAddresses[index];
                    final isSelected =
                        selectedAddress?.addressId == address.addressId;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAddress = address;
                        });
                        _adsController.addressId = address.addressId;
                        Navigator.pop(context);
                      },

                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor.withValues(alpha: 0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                            width: 1.2,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                shape: BoxShape.circle,
                              ),

                              child: Icon(
                                Icons.location_on,
                                color: AppColors.primaryColor,
                                size: 22.sp,
                              ),
                            ),
                            12.wt,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  primaryText(
                                    text:
                                        "${address.country}, ${address.state}, ${address.city}",
                                    fontSize: 15.sp,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  4.ht,
                                  secondaryText(
                                    text: "${address.address}",
                                    fontSize: 13.sp,
                                    color: Colors.grey.shade700,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  if (address.postalCode != null &&
                                      address.postalCode!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.h),
                                      child: secondaryText(
                                        text:
                                            "Postal Code: ${address.postalCode}",
                                        fontSize: 12.sp,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: AppColors.primaryColor,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userAddress = ref.watch(addressStateControllerProvider);
    final user = ref.watch(userControllerStateProvider);

    if (user != null && user.userSkills != null) {
      categories = user.userSkills!.map((skill) => skill.skill).toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(
        title: widget.adsData == null ? 'Post Ads' : "Edit Ads",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  20.ht,
                  secondaryText(
                    text:
                        "Kindly fill all details correctly and follow our rules",
                    color: Colors.red.withValues(alpha: 0.85),
                  ),
                  20.ht,
                  secondaryText(
                    text: "For the Title only 30 character max is allowed!!!",
                    color: Colors.red,
                  ),
                  20.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthTextFiled(
                        titleText: "Ad Title",
                        hintText: "Ads title",
                        textEditingController:
                            _adsController.adsTitleController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z\s]"),
                          ),
                          LengthLimitingTextInputFormatter(30),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Filed need to be filled";
                          }
                          if (value.length > 30) {
                            return "Cant be more than 30 Character";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _currentTitleTextLength = value.length;
                          });
                        },
                      ),
                      Row(
                        children: [
                          Container(width: 50.w),
                          secondaryText(
                            text: "$_currentTitleTextLength /30",
                            color: _currentTitleTextLength > 25
                                ? Colors.red
                                : AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  20.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: "Category", fontSize: 18.sp),
                      5.ht,
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 10.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: DropdownButton<String>(
                          hint: secondaryText(text: "Select Category"),
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          isExpanded: true,
                          value: categorySelected,
                          underline: SizedBox(),
                          items: categories.map((state) {
                            return DropdownMenuItem<String>(
                              value: state,
                              child: secondaryText(text: state),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _adsController.category = value;
                            setState(() {
                              categorySelected = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  20.ht,
                  AuthTextFiled(
                    titleText: "Ad Base Price",
                    hintText: "Enter base price",
                    textEditingController: _adsController.adsPriceController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Filed need to be filled";
                      }
                      if (value.length > 4) {
                        return "Cant be more than 4 Character";
                      }
                      return null;
                    },
                  ),
                  20.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: "Upload Pictures", fontSize: 18.sp),
                      5.ht,
                      // ImageSelectWidget(
                      //   type: ImageType.ads,
                      //   onImageSelected: (file) {
                      //     _adsController.imageSelected = file;
                      //   },
                      // ),
                      MultiImageSelectWidget(
                        imageType: ImageType.ads,
                        onImagesSelected: (files) {
                          _adsController.imageSelected = files;
                        },
                      ),
                    ],
                  ),
                  20.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: "Available Date", fontSize: 18.sp),
                      5.ht,
                      GestureDetector(
                        onTap: () async {
                          setState(() => isOpen = !isOpen);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 10.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: secondaryText(
                                  text: selectedDateTimes.isEmpty
                                      ? "Select Available Dates"
                                      : selectedDateTimes.entries
                                            .map((entry) {
                                              final date = entry.key;
                                              return "${date.day}/${date.month}/${date.year}";
                                            })
                                            .join(", "),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                isOpen
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///  CALENDAR (ONLY SHOW WHEN OPEN)
                      AnimatedCrossFade(
                        duration: Duration(milliseconds: 250),
                        crossFadeState: isOpen
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: Container(
                          margin: EdgeInsets.only(top: 5.h),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: CalendarDatePicker2(
                            config: CalendarDatePicker2Config(
                              calendarType: CalendarDatePicker2Type.multi,
                              firstDate: DateTime.now(),
                            ),

                            value: _date,

                            onValueChanged: (dates) async {
                              setState(() {
                                _date = dates;
                              });

                              ///  IMMEDIATE TIME PICK AFTER DATE
                              for (var d in dates.whereType<DateTime>()) {
                                if (!selectedDateTimes.containsKey(d)) {
                                  final times = await _showTimePickerDialog(d);
                                  if (times != null && times.isNotEmpty) {
                                    setState(() {
                                      selectedDateTimes[d] = times;
                                    });
                                  }
                                }
                              }
                              buildSchedule();

                              setState(() {
                                isOpen = false;
                              });
                            },
                          ),
                        ),

                        secondChild: SizedBox(),
                      ),

                      10.ht,

                      ///  SELECTED DATE + TIME (IMMEDIATE DISPLAY)
                      Column(
                        children: selectedDateTimes.entries.map((entry) {
                          final date = entry.key;
                          final times = entry.value;

                          return Container(
                            margin: EdgeInsets.only(top: 12.h),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// HEADER
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${date.day}/${date.month}/${date.year}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        /// EDIT
                                        GestureDetector(
                                          onTap: () async {
                                            final updated =
                                                await _showTimePickerDialog(
                                                  date,
                                                );

                                            if (updated != null) {
                                              setState(() {
                                                selectedDateTimes[date] =
                                                    updated;
                                              });
                                              buildSchedule();
                                            }
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 18,
                                            color: Colors.blue,
                                          ),
                                        ),

                                        SizedBox(width: 10),

                                        /// DELETE
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedDateTimes.remove(date);
                                              _date.remove(date);
                                            });
                                            buildSchedule();
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 18,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),

                                /// TIMES
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: times.map((t) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.green),
                                      ),
                                      child: Text(
                                        t,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.green.shade800,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  20.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: "Ads Active", fontSize: 18.sp),
                      5.ht,
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 10.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: DropdownButton<String>(
                          hint: secondaryText(text: "Select Status"),
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          isExpanded: true,
                          value: statusSelected,
                          underline: SizedBox(),
                          items: status.map((staus) {
                            return DropdownMenuItem<String>(
                              value: staus,
                              child: secondaryText(text: staus),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _adsController.updateStatus(value!);
                            setState(() {
                              statusSelected = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  20.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: "Select Address", fontSize: 18.sp),
                      5.ht,
                      GestureDetector(
                        onTap: () {
                          if (userAddress.isEmpty) {
                            showErrorNotification(
                              message:
                                  "No address found. Kindly add address first.",
                            );
                            return;
                          }
                          _showAddressBottomSheet(userAddress);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 12.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),

                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              10.wt,
                              Expanded(
                                child: selectedAddress == null
                                    ? secondaryText(
                                        text: "Tap to select address",
                                        color: Colors.grey.shade700,
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          primaryText(
                                            text:
                                                "${selectedAddress!.country}, ${selectedAddress!.state}, ${selectedAddress!.city}",
                                            fontSize: 14.sp,
                                          ),
                                          3.ht,
                                          secondaryText(
                                            text: "${selectedAddress!.address}",
                                            fontSize: 12.sp,
                                          ),

                                          if (selectedAddress!
                                                  .postalCode
                                                  ?.isNotEmpty ??
                                              false)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 3.h,
                                              ),

                                              child: secondaryText(
                                                text:
                                                    "Postal Code: ${selectedAddress!.postalCode}",
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                        ],
                                      ),
                              ),

                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey.shade700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.ht,
                  TextFiledHolder(
                    titleText: 'About Ads',
                    inputFormatters: [LengthLimitingTextInputFormatter(100)],
                    containerHeight: 150.h,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Filed need to be filled";
                      }
                      if (value.length == 101) {
                        return "Only 100 characters is allowed";
                      }
                      return null;
                    },
                    hintText:
                        'Write Short About Ads... only 100 character is allowed',
                    textAlign: TextAlign.start,
                    controller: _adsController.adsAboutController,
                  ),
                  30.ht,
                  AppButton(
                    text: widget.adsData == null ? "Submit" : "Update",
                    fontSize: 18.sp,
                    width: double.infinity,
                    bckColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    function: () {
                      if (selectedAddress == null) {
                        showErrorNotification(
                          message: "Please select an address",
                        );
                        return;
                      }
                      if (widget.adsData == null) {
                        if (_formKey.currentState!.validate()) {
                          _adsController.postAds(context, ref);
                        }
                      } else {
                        if (_formKey.currentState!.validate()) {
                          _adsController.updateAds(
                            context,
                            ref,
                            widget.adsData!,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
