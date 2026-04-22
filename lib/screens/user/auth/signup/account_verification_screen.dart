import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/account_verification_controller.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../utilities/app_button.dart';
import '../../../../widget/app_text.dart';

class AccountVerificationScreen extends StatefulWidget {
  const AccountVerificationScreen({super.key});

  @override
  State<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  late AccountVerificationController _accountVerificationController;

  @override
  void didChangeDependencies() {
    _accountVerificationController = AccountVerificationController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.ht,
                Center(child: primaryText(text: 'Verify Account')),
                20.ht,
                PinCodeTextField(
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  length: 4,
                  controller: _accountVerificationController.otpController,
                  onChanged: (value) {},
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10.r),
                    fieldHeight: 60.h,
                    fieldWidth: 60.w,
                    activeFillColor: AppColors.containerLightBackground,
                  ),
                ),
                10.ht,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    primaryText(text: "Don't Receive Otp?", fontSize: 14.sp),
                    primaryText(
                      text: "Re-send Code",
                      fontSize: 13.sp,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
                20.ht,
                AppButton(
                  text: 'Verify',
                  bckColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  width: double.infinity,
                  fontSize: 18.sp,
                  function: () {
                    _accountVerificationController.submitCode(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
