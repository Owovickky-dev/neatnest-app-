import 'package:country_state_city/country_state_city.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/ads_controller.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../widget/app_bar_holder.dart';
import '../../../history/utilities/text_filed_holder.dart';
import '../../utilities/auth_text_filed.dart';

class PostAdsScreen extends ConsumerStatefulWidget {
  const PostAdsScreen({super.key});

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
  final List<String> status = ["True", "False"];

  List<Country> countries = [];
  List<State> states = [];

  String? categorySelected;
  String? statusSelected;
  Country? countrySelected;
  State? stateSelected;

  @override
  void initState() {
    super.initState();
    _adsController = AdsController();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    List<Country> countryList = await getAllCountries();
    setState(() {
      countries = countryList;
    });
  }

  Future<void> _loadStates(String countryCode) async {
    List<State> stateList = await getStatesOfCountry(countryCode);
    setState(() {
      states = stateList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Post Ads'),
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
                    text: "For the about only 100 character is allowed!!!",
                    color: Colors.red,
                  ),
                  20.ht,
                  AuthTextFiled(
                    titleText: "Ad Title",
                    hintText: "Ads title",
                    textEditingController: _adsController.adsTitleController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Filed need to be filled";
                      }
                      if (value.length > 22) {
                        return "Cant be more than 20 Character";
                      }
                      return null;
                    },
                  ),
                  20.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: "Category", fontSize: 14.sp),
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
                  AuthTextFiled(
                    titleText: "Ad Image",
                    hintText: "ads image",
                    textEditingController: _adsController.adsImageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Filed need to be filled";
                      }
                      return null;
                    },
                  ),
                  20.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: "Ads Active", fontSize: 14.sp),
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
                          items: status.map((state) {
                            return DropdownMenuItem<String>(
                              value: state,
                              child: secondaryText(text: state),
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
                      primaryText(text: "Ads Country", fontSize: 14.sp),
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
                        child: DropdownButton<Country>(
                          hint: secondaryText(text: "Select Country"),
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          isExpanded: true,
                          value: countrySelected,
                          underline: SizedBox(),
                          items: countries.map((state) {
                            return DropdownMenuItem<Country>(
                              value: state,
                              child: secondaryText(text: state.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              _adsController.country = value.toString();
                              setState(() {
                                countrySelected = value;
                                stateSelected = null;
                                states = [];
                              });
                              _loadStates(value.isoCode);
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
                      primaryText(text: "Ads State", fontSize: 14.sp),
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
                        child: DropdownButton<State>(
                          hint: secondaryText(text: "Select State"),
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          isExpanded: true,
                          value: stateSelected,
                          underline: SizedBox(),
                          items: states.map((state) {
                            return DropdownMenuItem<State>(
                              value: state,
                              child: secondaryText(text: state.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              _adsController.state = value.toString();
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
                    text: "Submit",
                    fontSize: 18.sp,
                    width: double.infinity,
                    bckColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    function: () {
                      print("Post ads is cliced");
                      if (_formKey.currentState!.validate()) {
                        _adsController.postAds(context, ref);
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
