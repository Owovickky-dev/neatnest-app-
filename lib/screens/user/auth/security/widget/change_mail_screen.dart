import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/security_data_update_controller.dart';
import 'package:neat_nest/screens/user/utilities/auth_text_filed.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../../../widget/app_bar_holder.dart';
import '../../../../../widget/app_text.dart';

class ChangeMailScreen extends ConsumerStatefulWidget {
  const ChangeMailScreen({super.key});

  @override
  ConsumerState<ChangeMailScreen> createState() => _ChangeMailScreenState();
}

class _ChangeMailScreenState extends ConsumerState<ChangeMailScreen> {
  final _formKey = GlobalKey<FormState>();
  late SecurityDataUpdateController _securityDataUpdateController;

  @override
  void initState() {
    super.initState();
    _securityDataUpdateController = SecurityDataUpdateController();
  }

  String? enteredMail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Change mail'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                20.ht,
                secondaryText(
                  text:
                      "Kindly Note Update can only happen once in 30 days from last update !!!",
                  color: Colors.red,
                ),
                20.ht,
                secondaryText(
                  text: "Kindly filled below details to update your Email",
                  color: Colors.red.withValues(alpha: 0.8),
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "Old Email",
                  hintText: "Enter Old Mail",
                  textEditingController:
                      _securityDataUpdateController.oldEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Filed need to be filled";
                    }
                    if (!EmailValidator.validate(value)) {
                      return "Email is invalid, enter valid mail";
                    }
                    return null;
                  },
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "New Email",
                  hintText: "Enter New Mail",
                  textEditingController:
                      _securityDataUpdateController.newEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Filed need to be filled";
                    }
                    if (!EmailValidator.validate(value)) {
                      return "Email is invalid, enter valid mail";
                    }
                    return null;
                  },
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "Account Password",
                  hintText: "Enter password",
                  secure: true,
                  textEditingController:
                      _securityDataUpdateController.newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field need to be filled";
                    }
                    if (value.length < 8) {
                      return "password is more than 8 character";
                    }
                    return null;
                  },
                ),
                30.ht,
                AppButton(
                  text: "Submit",
                  width: double.infinity,
                  fontSize: 18.sp,
                  bckColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  function: () {
                    if (_formKey.currentState!.validate()) {
                      _securityDataUpdateController.updateMail(context, ref);
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
