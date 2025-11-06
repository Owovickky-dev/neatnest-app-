import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/add_user_payment_controller.dart';
import 'package:neat_nest/screens/user/widgets/payment/widgets/payment_method_fields.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/app_data.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../../utilities/constant/colors.dart';

class AddPaymentMethod extends ConsumerStatefulWidget {
  const AddPaymentMethod({super.key});

  @override
  ConsumerState<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends ConsumerState<AddPaymentMethod> {
  final List<String> paymentCountry = [
    "USA",
    "International Africa",
    "International EU",
    "International USA",
    "International UK",
    "PayPal",
  ];

  String? userPicked;
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers = {};
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

  void _onSavePressed() {
    final controller = ref.read(addUserPaymentControllerProvider);
    controller.savePaymentMethod(
      context: context,
      selectedCountry: userPicked,
      controllers: _controllers,
    );
  }

  List<String> get _currentFields {
    return userPicked != null ? AppData.desireMethod[userPicked]! : [];
  }

  @override
  void dispose() {
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
            _buildInstructionText(),
            20.ht,
            _buildCountryDropdown(),
            30.ht,
            if (userPicked != null) _buildPaymentFields(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionText() {
    return primaryText(
      text: "Please fill in the correct bank details",
      color: Colors.red,
      fontSize: 14.sp,
    );
  }

  Widget _buildCountryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        secondaryText(
          text: "Kindly Select Your choice ",
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
            underline: const SizedBox(),
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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AppButton(
        text: "Save Payment Method",
        bckColor: AppColors.primaryColor,
        textColor: Colors.white,
        function: _onSavePressed,
        fontSize: 18.sp,
      ),
    );
  }
}
