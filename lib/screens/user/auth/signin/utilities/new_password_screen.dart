import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/account_verification_controller.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../../../utilities/app_button.dart';
import '../../../../../utilities/constant/colors.dart';
import '../../../../../widget/app_text.dart';
import '../../../utilities/auth_text_filed.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.ht,
              Center(child: primaryText(text: 'New Password')),
              20.ht,
              AuthTextFiled(
                titleText: 'Password',
                secure: true,
                hintText: 'Password',
                textEditingController:
                    _accountVerificationController.newPasswordController,
              ),
              20.ht,
              AuthTextFiled(
                titleText: 'Confirm Password',
                secure: true,
                hintText: 'Password',
                textEditingController:
                    _accountVerificationController.confirmNewPasswordController,
              ),
              20.ht,
              AppButton(
                text: 'Create New Password',
                bckColor: AppColors.primaryColor,
                textColor: Colors.white,
                width: double.infinity,
                fontSize: 18.sp,
                function: () {
                  _accountVerificationController.submitNewPassword(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
