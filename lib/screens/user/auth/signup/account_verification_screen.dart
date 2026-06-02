import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/account_verification_controller.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../utilities/app_button.dart';
import '../../../../widget/app_text.dart';

class AccountVerificationScreen extends StatefulWidget {
  const AccountVerificationScreen({super.key, required this.userMail});

  final String userMail;

  @override
  State<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  late AccountVerificationController _accountVerificationController;

  int secondLeft = 60;
  Timer? timer;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void didChangeDependencies() {
    _accountVerificationController = AccountVerificationController();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    setState(() {
      secondLeft = 60;
      canResend = false;
    });

    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondLeft <= 1) {
        setState(() {
          secondLeft = 0;
          canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          secondLeft--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _accountVerificationController.userMail = widget.userMail;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarHolder(title: "Mail Verification"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.ht,
                primaryText(
                  text:
                      'Please kindly enter the 6 digits code sent to your mail to verify your email',
                  fontSize: 14.sp,
                ),
                20.ht,
                PinCodeTextField(
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  length: 6,
                  controller: _accountVerificationController.otpController,
                  onChanged: (value) {
                    _accountVerificationController.otpCode = value;
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(7.r),
                    fieldHeight: 40.h,
                    fieldWidth: 40.w,
                    activeFillColor: AppColors.containerLightBackground,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    primaryText(text: "Don't Receive Otp?", fontSize: 14.sp),
                    TextButton(
                      onPressed: canResend
                          ? () async {
                              await _accountVerificationController.resendCode(
                                context,
                              );
                              startCountdown();
                            }
                          : null,
                      child: primaryText(
                        text: canResend
                            ? "Re-send Code"
                            : "Resend code in $secondLeft",
                        fontSize: 14.sp,
                        color: canResend ? AppColors.primaryColor : Colors.grey,
                      ),
                    ),
                  ],
                ),
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
