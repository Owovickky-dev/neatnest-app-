import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../../../controller/security_data_update_controller.dart';
import '../../../../../utilities/app_button.dart';
import '../../../../../utilities/constant/colors.dart';
import '../../../../../widget/app_bar_holder.dart';
import '../../../../../widget/app_text.dart';
import '../../../utilities/auth_text_filed.dart';

class ChangePhoneNumberScreen extends ConsumerStatefulWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  ConsumerState<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState
    extends ConsumerState<ChangePhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  late SecurityDataUpdateController _securityDataUpdateController;

  @override
  void initState() {
    super.initState();
    _securityDataUpdateController = SecurityDataUpdateController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Change Phone Number'),
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
                  titleText: "Old Phone",
                  hintText: "Enter Old Phone",
                  textEditingController:
                      _securityDataUpdateController.oldPhoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Filed need to be filled";
                    }
                    return null;
                  },
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "New Phone",
                  hintText: "Enter New Phone",
                  textEditingController:
                      _securityDataUpdateController.newPhoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Filed need to be filled";
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
                      _securityDataUpdateController.updatePhoneNumber(
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
