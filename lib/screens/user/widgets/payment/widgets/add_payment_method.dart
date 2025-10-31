import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/screens/user/widgets/payment/widgets/payment_method_fields.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/app_data.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../../../../../utilities/constant/colors.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({super.key});

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  final List<String> paymentCountry = [
    "USA",
    "International Africa",
    "International EU",
    "International USA",
    "International UK",
    "PayPal",
  ];
  String? userPicked;

  // Map to store all controllers
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers = {};
    // Get all unique fields from all countries
    final allFields = AppData.desireMethod.values
        .expand((fields) => fields)
        .toSet();
    for (var field in allFields) {
      _controllers[field] = TextEditingController();
    }
  }

  void _onCountryChanged(String? country) {
    if (country != null) {
      setState(() {
        userPicked = country;
      });
    }
  }

  void _savePaymentMethod() {
    if (userPicked == null) {
      showErrorNotification(
        context: context,
        message: "Please select a country",
      );
      return;
    }

    // Validate required fields for selected country
    final requiredFields = AppData.desireMethod[userPicked]!;
    for (var field in requiredFields) {
      if (_controllers[field]!.text.trim().isEmpty) {
        showErrorNotification(
          context: context,
          message: 'Please fill in $field',
        );
        return;
      }
    }

    // Collect and save data
    final paymentData = _collectPaymentData();
    _saveToStorage(paymentData);

    showSuccessNotification(
      context: context,
      message: 'Payment method saved successfully',
    );
    context.pop();
  }

  Map<String, String> _collectPaymentData() {
    final paymentData = <String, String>{'Method': userPicked!};
    final requiredFields = AppData.desireMethod[userPicked]!;

    for (var field in requiredFields) {
      paymentData[field] = _controllers[field]!.text.trim();
    }

    return paymentData;
  }

  Future<void> _saveToStorage(Map<String, String> paymentData) async {
    // Implement your storage logic here
    print('Saving payment data: $paymentData');
    // await SecureStorageHelper.savePaymentMethod(jsonEncode(paymentData));
  }

  List<String> get _currentFields {
    return userPicked != null ? AppData.desireMethod[userPicked]! : [];
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHolder(title: "Add Payment Method"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.ht,

            // Instruction Text
            primaryText(
              text: "Please fill in the correct bank details",
              color: Colors.red,
              fontSize: 14.sp,
            ),
            20.ht,
            // Country Selection
            _buildCountryDropdown(),
            30.ht,
            // Dynamic Fields
            if (userPicked != null) _buildPaymentFields(),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        secondaryText(
          text: "Select Country",
          color: Colors.black,
          fontSize: 16.sp,
        ),
        8.ht,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: AppColors.textFieldBckColor.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: DropdownButton<String>(
            items: paymentCountry.map((country) {
              return DropdownMenuItem<String>(
                value: country,
                child: secondaryText(text: country, fontSize: 16.sp),
              );
            }).toList(),
            value: userPicked,
            hint: secondaryText(text: "Choose your method", fontSize: 16.sp),
            icon: Icon(Icons.arrow_drop_down, size: 24.sp),
            isExpanded: true,
            underline: SizedBox(),
            onChanged: _onCountryChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentFields() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          secondaryText(
            text:
                "Please kindly enter the correct details of method picked !!!",
            color: Colors.red,
            fontSize: 16.sp,
          ),
          15.ht,

          Expanded(
            child: ListView(
              children: [
                ..._currentFields.map(
                  (field) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: PaymentMethodFields(
                      title: field,
                      textEditingController: _controllers[field]!,
                    ),
                  ),
                ),

                // Save Button
                SizedBox(height: 30.h),
                _buildSaveButton(),
                20.ht,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withValues(alpha: .8),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: .3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: AppButton(
        text: "Save Payment Method",
        bckColor: AppColors.primaryColor,
        textColor: Colors.white,
        function: _savePaymentMethod,
        fontSize: 18.sp,
      ),
    );
  }
}
