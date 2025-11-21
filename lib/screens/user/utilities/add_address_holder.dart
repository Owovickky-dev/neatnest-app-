import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/add_address_holder_controller.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../utilities/app_button.dart';
import '../../../utilities/constant/colors.dart';
import '../../../widget/app_bar_holder.dart';
import 'auth_text_filed.dart';

class AddAddressHolder extends ConsumerStatefulWidget {
  const AddAddressHolder({super.key});

  @override
  ConsumerState<AddAddressHolder> createState() => _AddAddressHolderState();
}

class _AddAddressHolderState extends ConsumerState<AddAddressHolder> {
  late AddAddressHolderController _addAddressHolderController;
  List<String> isPrimary = ["Yes", "No"];

  List<String> countries = [];
  List<String> states = [];

  String? userPicked;
  String? statesPicked;
  String? isPrimaryPicked;

  @override
  void initState() {
    super.initState();
    _addAddressHolderController = AddAddressHolderController();
    loadCountries();
  }

  Future<void> loadStates() async {
    final statesList = await _addAddressHolderController.getStates(userPicked!);
    setState(() {
      states = statesList;
    });
  }

  Future<void> loadCountries() async {
    try {
      final countryList = await _addAddressHolderController
          .getCountriesOnline();
      setState(() {
        countries = countryList;
      });
    } catch (e) {
      setState(() {
        countries = ["Nigeria", "Ghana", "USA", "UK", "Canada"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Add Address'),
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
                text: "Kindly Fill in the Correct  Address details",
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
                              hint: secondaryText(text: "Select a country"),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              isExpanded: true,
                              value: userPicked,
                              underline: SizedBox(),
                              items: countries.map((country) {
                                return DropdownMenuItem<String>(
                                  value: country,
                                  child: secondaryText(text: country),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  userPicked = value!;
                                  _addAddressHolderController.printUserPicked(
                                    value,
                                  );
                                  _addAddressHolderController.countryPicked =
                                      value;
                                  statesPicked = null;
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
                              hint: secondaryText(text: "select state"),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              isExpanded: true,
                              value: statesPicked,
                              underline: SizedBox(),
                              items: states.map((country) {
                                return DropdownMenuItem<String>(
                                  value: country,
                                  child: secondaryText(text: country),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _addAddressHolderController.statePicked =
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
                              hint: secondaryText(text: "Select State"),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              isExpanded: true,
                              value: isPrimaryPicked,
                              underline: SizedBox(),
                              items: isPrimary.map((confirm) {
                                return DropdownMenuItem<String>(
                                  value: confirm,
                                  child: secondaryText(text: confirm),
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
                        text: "Submit",
                        fontSize: 18.sp,
                        width: double.infinity,
                        bckColor: AppColors.primaryColor,
                        textColor: Colors.white,
                        function: () {
                          _addAddressHolderController.submitAddress(
                            context,
                            ref,
                          );
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
