import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/security_data_update_controller.dart';
import 'package:neat_nest/screens/user/utilities/auth_text_filed.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../../widget/app_bar_holder.dart';

class UpdatePasswordScreen extends ConsumerStatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  ConsumerState<UpdatePasswordScreen> createState() =>
      _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends ConsumerState<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  late SecurityDataUpdateController _securityDataUpdateController;

  String? enteredPassword;

  @override
  void initState() {
    super.initState();
    _securityDataUpdateController = SecurityDataUpdateController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Update Password'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                20.ht,
                secondaryText(
                  text: "Kindly filled below details to update your password",
                  color: Colors.red.withValues(alpha: 0.7),
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "Old Password",
                  hintText: "Enter old password",
                  secure: true,
                  textEditingController:
                      _securityDataUpdateController.oldPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password field is required";
                    }
                    if (value.length < 8) {
                      return "Minimum character required is 8";
                    }
                    return null;
                  },
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "New Password",
                  secure: true,
                  hintText: "Enter New password",
                  textEditingController:
                      _securityDataUpdateController.newPasswordController,
                  onChanged: (val) {
                    setState(() {
                      enteredPassword = val;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password field is required";
                    }
                    if (value.length < 8) {
                      return "Password must be 8 more than 8 characters";
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return "Password must contain  at least one capital letter";
                    }
                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return "Password must contain  at least one small letter";
                    }
                    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return "Password must contain at least one special character";
                    }
                    return null;
                  },
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "Confirm New Password",
                  hintText: "Confirm New password",
                  secure: true,
                  textEditingController:
                      _securityDataUpdateController.confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password field is required";
                    }
                    if (value != enteredPassword) {
                      return "Password don't match ";
                    }
                    return null;
                  },
                ),
                30.ht,
                AppButton(
                  text: "Submit",
                  fontSize: 20.sp,
                  width: double.infinity,
                  bckColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  function: () {
                    if (_formKey.currentState!.validate()) {
                      _securityDataUpdateController.updatePassword(
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
      ),
    );
  }
}
