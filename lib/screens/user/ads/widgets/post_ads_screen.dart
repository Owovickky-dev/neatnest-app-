import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:country_state_city/country_state_city.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/ads_controller.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/image_upload_helper.dart';
import 'package:neat_nest/widget/select_image_helper.dart';

import '../../../../widget/app_bar_holder.dart';
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
  final _formKey = GlobalKey<FormState>();
  List<String> categories = [
    "Cleaning",
    "Plumbing",
    "Electrical",
    "Carpentry",
    "Painting",
    "Gardening",
    "Moving",
    "Assembly",
    "Repair",
    "Other",
  ];
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
  final List<DateTime?> _date = [];
  List<Country> countries = [];
  List<State> states = [];
  final List<String> selectedTimes = [];
  bool isOpen = false;
  int _currentTitleTextLength = 0;
  List<WorkerAvailableInfoModel> workerAvailableTime = [];

  String? categorySelected;
  String? statusSelected;
  String? countrySelected;
  String? stateSelected;

  @override
  void initState() {
    super.initState();
    _adsController = AdsController();

    _loadCountries().then((_) {
      if (widget.adsData != null && mounted) {
        _adsController.id = widget.adsData?.id;
        prefilledData();
      }
    });
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
      countrySelected = myAds.country!;
    });
    _loadStates(myAds.country!, myAds.state!);
  }

  Future<void> _loadCountries() async {
    List<Country> countryList = await getAllCountries();
    setState(() {
      countries = countryList;
    });
  }

  Future<void> _loadStates(String countryName, String? stateName) async {
    Country? userPickedCountry;
    try {
      userPickedCountry = countries.firstWhere(
        (country) => country.name == countryName,
      );
    } catch (e) {
      return;
    }
    List<State> stateList = await getStatesOfCountry(userPickedCountry.isoCode);

    setState(() {
      states = stateList;

      if (stateName != null && stateName.isNotEmpty) {
        try {
          final matchedState = states.firstWhere(
            (state) => state.name == stateName,
          );
          stateSelected = matchedState.name;
        } catch (e) {
          stateSelected = null;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    hintText: "enter base price",
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
                      primaryText(text: "Upload Pic", fontSize: 18.sp),
                      5.ht,
                      ImageSelectWidget(
                        type: ImageType.ads,
                        onImageSelected: (file) {
                          _adsController.imageSelected = file;
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
                        onTap: () {
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
                                  text: _date.isEmpty
                                      ? "Select Available Dates"
                                      : _date
                                            .whereType<DateTime>()
                                            .map(
                                              (date) =>
                                                  "${date.day}/${date.month}/${date.year}",
                                            )
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

                      if (isOpen)
                        Container(
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
                              disableModePicker: false,
                              firstDate: DateTime.now(),
                            ),
                            value: _date,
                            onValueChanged: (dates) {},
                          ),
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
                      primaryText(text: "Ads Country", fontSize: 18.sp),
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
                          hint: secondaryText(text: "Select Country"),
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          isExpanded: true,
                          value: countrySelected,
                          underline: SizedBox(),
                          items: countries.map((country) {
                            return DropdownMenuItem<String>(
                              value: country.name,
                              child: secondaryText(text: country.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              _adsController.country = value;
                              setState(() {
                                countrySelected = value;
                                stateSelected = null;
                                states = [];
                              });
                              _loadStates(value, null);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  20.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: "Ads State", fontSize: 18.sp),
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
                          hint: secondaryText(text: "Select State"),
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          isExpanded: true,
                          value: stateSelected,
                          underline: SizedBox(),
                          items: states.map((state) {
                            return DropdownMenuItem<String>(
                              value: state.name,
                              child: secondaryText(text: state.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              _adsController.state = value;
                              setState(() {
                                stateSelected = value;
                              });
                            }
                          },
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
