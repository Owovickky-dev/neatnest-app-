import 'package:dotted_line/dotted_line.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/sign_up_controller.dart';
import 'package:neat_nest/screens/user/auth/icon_holder.dart';
import 'package:neat_nest/screens/user/utilities/auth_text_filed.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpController _signUpController;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  final List<String> roles = const ["User", "Service Provider"];
  final List<String> gender = const ["Male", "Female"];
  String? positionGen;
  String? position;
  String? onChange;

  @override
  void didChangeDependencies() {
    _signUpController = SignUpController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: primaryText(text: 'Sign Up'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.ht,
                  AuthTextFiled(
                    titleText: 'Name',
                    textInputType: TextInputType.name,
                    hintText: 'Enter Full Name',
                    textEditingController: _signUpController.nameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You need to enter Name";
                      }
                      return null;
                    },
                  ),
                  8.ht,
                  AuthTextFiled(
                    titleText: 'Email Address',
                    hintText: 'Enter Email Address',
                    textEditingController: _signUpController.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field can't be empty";
                      }
                      if (!EmailValidator.validate(value)) {
                        return "Kindly Enter a valid mail";
                      }
                      return null;
                    },
                  ),
                  8.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: "Role", fontSize: 14.sp),
                      5.ht,
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textFieldBckColor.withValues(
                            alpha: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: DropdownButton(
                          hint: secondaryText(text: "Select Role"),
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          isExpanded: true,
                          value: position,
                          underline: SizedBox(),
                          items: roles.map((role) {
                            return DropdownMenuItem(
                              value: role,
                              child: secondaryText(text: role),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                position = value;
                              });
                              _signUpController.setRole(value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  8.ht,
                  AuthTextFiled(
                    titleText: 'UserName',
                    hintText: 'Enter UserName',
                    textEditingController: _signUpController.userNameController,
                    onChanged: (val) {
                      setState(() {
                        onChange = val;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You need to enter Name";
                      }
                      if (value.length < 3) {
                        return "Password must be more than 3 character";
                      }
                      return null;
                    },
                  ),
                  8.ht,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: "Gender", fontSize: 14.sp),
                      5.ht,
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textFieldBckColor.withValues(
                            alpha: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: DropdownButton(
                          hint: secondaryText(text: "Select Gender"),
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          isExpanded: true,
                          value: position,
                          underline: SizedBox(),
                          items: gender.map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: secondaryText(text: gender),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                position = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  8.ht,
                  AuthTextFiled(
                    titleText: 'Password',
                    hintText: 'Enter Password',
                    secure: true,
                    textEditingController: _signUpController.passwordController,
                    onChanged: (val) {
                      setState(() {
                        onChange = val;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You need to enter Name";
                      }
                      if (value.length < 8) {
                        return "Password must be more than 8 character";
                      }
                      return null;
                    },
                  ),
                  8.ht,
                  AuthTextFiled(
                    titleText: 'Confirm Password',
                    hintText: 'Confirm Password',
                    secure: true,
                    textEditingController:
                        _signUpController.confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Must not be empty";
                      }
                      if (value != onChange) {
                        return "Password don't match";
                      }
                      return null;
                    },
                  ),
                  8.ht,
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: AppColors.primaryColor,
                        side: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                        value: isChecked,
                        onChanged: (val) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                          _signUpController.setChecked(val!);
                        },
                      ),
                      secondaryText(text: 'I agree to the', fontSize: 13.sp),
                      primaryText(
                        text: 'Terms and Conditions',
                        color: AppColors.primaryColor,
                        fontSize: 13.sp,
                      ),
                    ],
                  ),
                  10.ht,
                  AppButton(
                    text: 'Submit',
                    bckColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    width: double.infinity,
                    fontSize: 18.sp,
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        _signUpController.testingData(context);
                      }
                    },
                  ),
                  10.ht,
                  DottedLine(dashColor: AppColors.secondaryTextColor),
                  15.ht,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconHolder(
                        imagePath:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWryx19r0yjTs-vYzgN8-moMYY9Kf4lWDqrg&s',
                      ),
                      20.wt,
                      iconHolder(
                        imagePath:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdP6AKFlNa3Afg4RJOp7OtR7RGRrlPE2KbLg&s',
                      ),
                    ],
                  ),
                  10.ht,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      secondaryText(text: 'Already have an account?'),
                      GestureDetector(
                        onTap: () {
                          AppNavigatorHelper.push(context, AppRoute.signIn);
                        },
                        child: secondaryText(
                          text: 'SignIn',
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
