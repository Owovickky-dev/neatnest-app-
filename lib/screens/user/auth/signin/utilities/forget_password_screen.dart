import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../../controller/password_controller.dart';
import '../../../../../utilities/app_button.dart';
import '../../../../../utilities/constant/colors.dart';
import '../../../utilities/auth_text_filed.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late PasswordController _passwordResetController;

  @override
  void didChangeDependencies() {
    _passwordResetController = PasswordController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarHolder(title: 'Forgot Password'),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ht,
                secondaryText(
                  text:
                      "Please kindly enter your mail to get the reset token to reset your account password",
                  fontSize: 15.sp,
                ),
                20.ht,
                AuthTextFiled(
                  titleText: 'Email Address',
                  hintText: 'Enter Email Address',
                  textEditingController: _passwordResetController.passwordReset,
                ),
                40.ht,
                AppButton(
                  text: 'Send Code',
                  bckColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  width: double.infinity,
                  fontSize: 18.sp,
                  function: () {
                    _passwordResetController.forgotPassword(context);
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
