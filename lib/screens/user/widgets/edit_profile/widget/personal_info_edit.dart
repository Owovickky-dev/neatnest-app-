import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/edit_profile_controller.dart';
import 'package:neat_nest/screens/user/utilities/auth_text_filed.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class PersonalInfoEdit extends ConsumerStatefulWidget {
  const PersonalInfoEdit({super.key});

  @override
  ConsumerState<PersonalInfoEdit> createState() => _PersonalInfoEditState();
}

class _PersonalInfoEditState extends ConsumerState<PersonalInfoEdit> {
  late EditProfileController _editProfileController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Auto refresh countdown for UI
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
      // stop the timer when both cooldowns are done
      if (_editProfileController.canEditDetails() &&
          _editProfileController.canUserNameDetails()) {
        timer.cancel();
      }
    });
  }

  @override
  void didChangeDependencies() {
    _editProfileController = EditProfileController();
    _editProfileController.verifiedDetails(ref);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: "Personal Information"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              10.ht,
              secondaryText(
                text:
                    "Kindly note that your FullName and UserName can only be edited once in 90 days and also will need re-verification and kindly remember to click the all chnages to make the changes take effect",
                color: Colors.red,
              ),
              20.ht,
              AuthTextFiled(
                titleText: "Full Name",
                hintText: "Name",
                textInputType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                ],
                textEditingController: _editProfileController.fNameController,
                readOnly: !_editProfileController.canEditDetails(),
                onTap: () {
                  if (!_editProfileController.canEditDetails()) {
                    showErrorNotification(
                      context: context,
                      message:
                          "Name can't be edited for security reasons. Wait ${_editProfileController.timeLeft()}s",
                    );
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Full name is required cant be empty";
                  }
                  return null;
                },
              ),
              20.ht,
              AuthTextFiled(
                titleText: "Username",
                hintText: "Username",
                textInputType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                ],
                textEditingController:
                    _editProfileController.userNameController,
                readOnly: !_editProfileController.canUserNameDetails(),
                onTap: () {
                  if (!_editProfileController.canUserNameDetails()) {
                    showErrorNotification(
                      context: context,
                      message:
                          "UserName can't be edited for security reasons. Wait ${_editProfileController.userNameTimeLeft()}s",
                    );
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "User name is required cant be empty";
                  }
                  return null;
                },
              ),
              20.ht,
              AuthTextFiled(
                titleText: "Telephone",
                hintText: "telephone",
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textEditingController:
                    _editProfileController.phoneNumberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Phone number is required cant be empty";
                  }
                  return null;
                },
              ),
              20.ht,
              AuthTextFiled(
                titleText: "Email",
                hintText: "Email",
                textEditingController: _editProfileController.emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is required cant be empty";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Kindly enter a valid mail";
                  }
                  return null;
                },
              ),
              30.ht,
              AppButton(
                text: "Save Personal Info",
                bckColor: AppColors.primaryColor,
                textColor: Colors.white,
                width: double.infinity,
                fontSize: 23.sp,
                function: () {
                  if (_formKey.currentState!.validate()) {
                    _editProfileController.continueButton();
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
