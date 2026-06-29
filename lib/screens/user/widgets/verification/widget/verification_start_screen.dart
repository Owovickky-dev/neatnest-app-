import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';

import '../../../../../utilities/app_button.dart';
import '../../../../../utilities/constant/colors.dart';
import '../../../../../widget/app_bar_holder.dart';
import '../../../../../widget/app_text.dart';

class VerificationStartScreen extends StatelessWidget {
  const VerificationStartScreen({super.key, required this.isStart});

  final bool isStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHolder(title: "Identity Verification"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          5.ht,
          SizedBox(
            height: 300.h,
            width: double.infinity,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "https://thumbs.dreamstime.com/b/identity-verification-security-blue-tones-user-profile-protection-checkmark-person-s-profile-verified-secure-380184097.jpg",
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator.adaptive()),
              errorWidget: (context, url, error) =>
                  Icon(Icons.person, color: Colors.grey, size: 30),
            ),
          ),
          20.ht,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Stack(
                children: [
                  Column(
                    children: [
                      primaryText(
                        text: isStart == true
                            ? "Continue your verification"
                            : "Verify Your Identity",
                      ),
                      10.ht,
                      secondaryText(
                        text: isStart == true
                            ? "You’ve already started your verification. Continue where you left off by submitting the remaining required documents. Once completed, we’ll review your information and notify you of the result as soon as possible."
                            : "As a part of the KYC (Know your customer) process, we request all our customers to verify their identity. "
                                  "This helps us ensure the safety and authenticity of all professionals workers on our platform. "
                                  "Please provide a valid government-issued ID, Utility Bills and a clear profile photo to complete verification. and valid document to verify each skills you you pledge in for",
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 40,
                    child: AppButton(
                      text: isStart == true ? "Continue" : "Start",
                      width: double.infinity,
                      fontSize: 24.sp,
                      bckColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      function: () {
                        AppNavigatorHelper.push(
                          context,
                          AppRoute.verificationMethodScreen,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
