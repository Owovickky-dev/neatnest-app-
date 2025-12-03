import 'package:dotted_line/dotted_line.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/sign_in_controller.dart';
import 'package:neat_nest/screens/user/auth/icon_holder.dart';
import 'package:neat_nest/screens/user/utilities/auth_text_filed.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../utilities/route/app_naviation_helper.dart';
import '../../../../utilities/route/app_route_names.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late SignInController _signInScreenController;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    _signInScreenController = SignInController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(
        title: 'Sign In',
        function: () {
          AppNavigatorHelper.go(context, AppRoute.welcome);
        },
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
                  20.ht,
                  AuthTextFiled(
                    titleText: 'Email Address',
                    hintText: 'Enter Email Address',
                    textEditingController:
                        _signInScreenController.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email can't be empty";
                      }
                      if (!EmailValidator.validate(value)) {
                        return "Please enter a valid mail";
                      }
                      return null;
                    },
                  ),
                  20.ht,
                  AuthTextFiled(
                    titleText: 'Password',
                    hintText: 'Enter Password',
                    secure: true,
                    textEditingController:
                        _signInScreenController.passwordController,
                    onChanged: (value) {
                      searchServices(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty";
                      }
                      if (value.length < 8) {
                        return "Atleast 8 character";
                      }
                      return null;
                    },
                  ),
                  10.ht,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                              _signInScreenController.setChecked(val!);
                            },
                          ),
                          secondaryText(text: 'Remember me', fontSize: 13.sp),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          AppNavigatorHelper.push(
                            context,
                            AppRoute.forgotPassword,
                          );
                        },
                        child: secondaryText(
                          text: 'Forgot Password',
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  20.ht,
                  AppButton(
                    text: 'Sign In',
                    bckColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    width: double.infinity,
                    fontSize: 18.sp,
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        _signInScreenController.submitData(context, ref);
                      }
                    },
                  ),
                  30.ht,
                  DottedLine(dashColor: AppColors.secondaryTextColor),
                  20.ht,
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
                  30.ht,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      secondaryText(text: 'Don\'t have and account?'),
                      GestureDetector(
                        onTap: () {
                          AppNavigatorHelper.push(context, AppRoute.signUp);
                        },
                        child: secondaryText(
                          text: 'SignUp',
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

  void searchServices(String value) {
    ///Debouncer
    Future.delayed(Duration(milliseconds: 2500), () {
      //endpoint that will take in the string
    });
  }
}
