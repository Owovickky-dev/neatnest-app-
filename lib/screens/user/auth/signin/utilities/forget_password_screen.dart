import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/password_reset_controller.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../../../utilities/app_button.dart';
import '../../../../../utilities/constant/colors.dart';
import '../../../../../widget/app_text.dart';
import '../../../utilities/auth_text_filed.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late PasswordResetController _passwordResetController;

  @override
  void didChangeDependencies() {
    _passwordResetController = PasswordResetController();
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
                10.ht,
                Center(child: primaryText(text: 'Forgot Password')),
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
                    _passwordResetController.submitMail(context);
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
