import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/add_address_holder_controller.dart';
import 'package:neat_nest/screens/user/model/user_location_model.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../utilities/app_button.dart';
import '../../../utilities/constant/colors.dart';
import '../../../widget/app_bar_holder.dart';
import 'auth_text_filed.dart';

class AddAddressHolder extends ConsumerStatefulWidget {
  const AddAddressHolder({super.key, this.preUserAddress});

  final UserLocationModel? preUserAddress;
  @override
  ConsumerState<AddAddressHolder> createState() => _AddAddressHolderState();
}

class _AddAddressHolderState extends ConsumerState<AddAddressHolder> {
  late AddAddressHolderController _addAddressHolderController;
  List<String> isPrimaryOptions = ["Yes", "No"];

  List<String> countries = [];
  List<String> states = [];

  String? countryPicked;
  String? statesPicked;
  String? isPrimaryPicked;

  bool isLoadingCountries = false;
  bool isLoadingStates = false;

  @override
  void initState() {
    super.initState();
    _addAddressHolderController = AddAddressHolderController();

    if (widget.preUserAddress != null) {
      _addAddressHolderController.preLoadData(widget.preUserAddress!);
      _preLoadCSD();

      if (widget.preUserAddress?.country != null) {
        countries = [widget.preUserAddress!.country!];
      }

      if (widget.preUserAddress?.state != null) {
        states = [widget.preUserAddress!.state!];
      }
    }

    // Load fresh data in background
    _initializeData();
  }

  void _preLoadCSD() {
    setState(() {
      countryPicked = widget.preUserAddress?.country;
      statesPicked = widget.preUserAddress?.state;
      isPrimaryPicked = widget.preUserAddress?.isPrimary == true ? "Yes" : "No";
    });
  }

  Future<void> _initializeData() async {
    await loadCountries();

    if (widget.preUserAddress != null && countryPicked != null) {
      await loadStates();
    }
  }

  Future<void> loadStates() async {
    if (countryPicked == null) return;

    setState(() {
      isLoadingStates = true;
    });

    try {
      final statesList = await _addAddressHolderController.getStates(
        countryPicked!,
      );
      if (mounted) {
        setState(() {
          states = statesList;
          // Only update statesPicked if it's not already set from preload
          if (statesPicked == null && statesList.isNotEmpty) {
            statesPicked = statesList.first;
          }
          isLoadingStates = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoadingStates = false;
        });
      }
      print("Error loading states: $e");
    }
  }

  Future<void> loadCountries() async {
    setState(() {
      isLoadingCountries = true;
    });

    try {
      final countryList = await _addAddressHolderController
          .getCountriesOnline();
      if (mounted) {
        setState(() {
          if (countryPicked != null && !countryList.contains(countryPicked)) {
            countries = [countryPicked!, ...countryList];
          } else {
            countries = countryList;
          }
          isLoadingCountries = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          // Ensure we at least have the preloaded country
          if (countries.isEmpty && countryPicked != null) {
            countries = [countryPicked!];
          }
          isLoadingCountries = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(
        title: widget.preUserAddress != null ? 'Edit Address' : 'Add Address',
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ht,
              primaryText(
                text: "Kindly Fill in the Correct Address details",
                color: Colors.red,
              ),
              20.ht,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AuthTextFiled(
                        titleText: 'Address*',
                        hintText: 'address',
                        textEditingController:
                            _addAddressHolderController.addressController,
                      ),
                      20.ht,
                      AuthTextFiled(
                        titleText: 'City*',
                        hintText: 'city',
                        textEditingController:
                            _addAddressHolderController.cityController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s\-]'),
                          ),
                        ],
                      ),
                      20.ht,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          primaryText(text: "Country*", fontSize: 14.sp),
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
                              hint: secondaryText(
                                text: isLoadingCountries
                                    ? "Loading Countries..."
                                    : "select country",
                              ),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              isExpanded: true,
                              value: countryPicked,
                              underline: SizedBox(),
                              items: countries.map((country) {
                                return DropdownMenuItem<String>(
                                  value: country,
                                  child: Row(
                                    children: [
                                      secondaryText(text: country),
                                      if (country ==
                                              widget.preUserAddress?.country &&
                                          isLoadingCountries)
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.w),
                                          child: SizedBox(
                                            width: 12.w,
                                            height: 12.h,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    AppColors.primaryColor,
                                                  ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: isLoadingCountries
                                  ? null
                                  : (value) {
                                      setState(() {
                                        countryPicked = value!;
                                        _addAddressHolderController
                                                .countryPicked =
                                            value;
                                        statesPicked = null;
                                        states = [];
                                        loadStates();
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
                          primaryText(text: "State*", fontSize: 14.sp),
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
                              hint: secondaryText(
                                text: isLoadingStates
                                    ? "Loading states..."
                                    : states.isEmpty
                                    ? "failed to load state"
                                    : "select state",
                              ),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              isExpanded: true,
                              value: statesPicked,
                              underline: SizedBox(),
                              items: states.map((state) {
                                return DropdownMenuItem<String>(
                                  value: state,
                                  child: secondaryText(text: state),
                                );
                              }).toList(),
                              onChanged: isLoadingStates
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _addAddressHolderController
                                                .statePicked =
                                            value;
                                        statesPicked = value!;
                                      });
                                    },
                            ),
                          ),
                        ],
                      ),
                      20.ht,
                      AuthTextFiled(
                        titleText: "Postal Code",
                        hintText: "6 digits postal code",
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        textEditingController:
                            _addAddressHolderController.postalController,
                      ),
                      20.ht,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          primaryText(text: "isPrimary", fontSize: 14.sp),
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
                              hint: secondaryText(text: "Select option"),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              isExpanded: true,
                              value: isPrimaryPicked,
                              underline: SizedBox(),
                              items: isPrimaryOptions.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: secondaryText(text: option),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  isPrimaryPicked = value!;
                                  _addAddressHolderController
                                      .getAddressCondition(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      20.ht,
                      AppButton(
                        text: widget.preUserAddress != null
                            ? "Update"
                            : "Submit",
                        fontSize: 18.sp,
                        width: double.infinity,
                        bckColor: AppColors.primaryColor,
                        textColor: Colors.white,
                        function: () {
                          if (widget.preUserAddress != null) {
                            _addAddressHolderController.updateAddressData(
                              context,
                              ref,
                              widget.preUserAddress!.addressId!,
                            );
                          } else {
                            _addAddressHolderController.submitAddress(
                              context,
                              ref,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
