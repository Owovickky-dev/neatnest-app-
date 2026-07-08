import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/password_controller.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../../utilities/app_button.dart';
import '../../../../../utilities/constant/colors.dart';
import '../../../utilities/auth_text_filed.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, required this.userMail});

  final String userMail;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  PasswordController passwordController = PasswordController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    passwordController.userMail = widget.userMail;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Scaffold(
        appBar: AppBarHolder(title: 'New Password'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ht,
              secondaryText(
                text:
                    "Please kindly enter your new password Atleast One capital letter, one small letter and special character is required",
                color: Colors.red.withValues(alpha: 0.8),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    20.ht,
                    AuthTextFiled(
                      titleText: 'Password',
                      secure: true,
                      hintText: 'Password',
                      textEditingController:
                          passwordController.newPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        if (value.length < 8) {
                          return "Minimum of 8 character required";
                        }
                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return "Atleast one capital letter is required";
                        }
                        if (!RegExp(r'[a-z]').hasMatch(value)) {
                          return "Atleast one small letter is required";
                        }
                        if (!RegExp(
                          r'[!@#$%^&*(),.?":{}|<>]',
                        ).hasMatch(value)) {
                          return "Must contain at least one special character";
                        }
                        return null;
                      },
                    ),
                    20.ht,
                    AuthTextFiled(
                      titleText: 'Confirm Password',
                      secure: true,
                      hintText: 'Password',
                      textEditingController:
                          passwordController.confirmNewPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm password is required";
                        }
                        return null;
                      },
                    ),
                    20.ht,
                  ],
                ),
              ),
              AppButton(
                text: 'Create New Password',
                bckColor: AppColors.primaryColor,
                textColor: Colors.white,
                width: double.infinity,
                fontSize: 18.sp,
                function: () {
                  if (_formKey.currentState!.validate()) {
                    passwordController.submitNewPassword(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
