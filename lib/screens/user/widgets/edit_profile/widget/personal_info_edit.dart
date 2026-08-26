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

class PersonalInfoEdit extends ConsumerStatefulWidget {
  const PersonalInfoEdit({super.key});

  @override
  ConsumerState<PersonalInfoEdit> createState() => _PersonalInfoEditState();
}

class _PersonalInfoEditState extends ConsumerState<PersonalInfoEdit> {
  late EditProfileController _editProfileController;

  final _formKey = GlobalKey<FormState>();

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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                10.ht,
                secondaryText(
                  text:
                      "Kindly note that your FullName can only be updated once in 60 days  and UserName once in 30 days ",
                  color: Colors.red,
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "First Name",
                  hintText: "Name",
                  textInputType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    LengthLimitingTextInputFormatter(15),
                  ],
                  textEditingController: _editProfileController.fNameController,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First name is required cant be empty";
                    }
                    return null;
                  },
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "Other Name(Optional)",
                  hintText: "Name",
                  textInputType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    LengthLimitingTextInputFormatter(15),
                  ],
                  textEditingController:
                      _editProfileController.otherNameController,
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "First Name",
                  hintText: "Name",
                  textInputType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    LengthLimitingTextInputFormatter(15),
                  ],
                  textEditingController:
                      _editProfileController.lastNameController,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Last name is required cant be empty";
                    }
                    return null;
                  },
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "Username",
                  hintText: "Username",
                  textInputType: TextInputType.name,
                  inputFormatters: [LengthLimitingTextInputFormatter(15)],
                  textEditingController:
                      _editProfileController.userNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "User name is required cant be empty";
                    }
                    return null;
                  },
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "Phone Number",
                  hintText: "Nos",
                  textInputType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\s\-()]')),
                    LengthLimitingTextInputFormatter(20),
                  ],
                  textEditingController:
                      _editProfileController.phoneNosController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone number is required cant be empty";
                    }
                    return null;
                  },
                ),
                20.ht,
                AuthTextFiled(
                  titleText: "Enter Password",
                  secure: true,
                  hintText: "Kindly enter your password",
                  textInputType: TextInputType.text,
                  textEditingController: _editProfileController.userPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required cant be empty";
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
                      _editProfileController.saveData(ref, context);
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
