import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neat_nest/controller/verification_controller.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/image_upload_helper.dart';

import '../../../../../utilities/constant/extension.dart';

class VerificationImageUploadHelper extends StatefulWidget {
  const VerificationImageUploadHelper({
    super.key,
    required this.title,
    this.address,
    this.city,
    this.state,
    this.postalCode,
  });

  final String title;
  final String? address;
  final String? city;
  final String? state;
  final String? postalCode;

  @override
  State<VerificationImageUploadHelper> createState() =>
      _VerificationImageUploadHelperState();
}

class _VerificationImageUploadHelperState
    extends State<VerificationImageUploadHelper> {
  final VerificationController _verificationController =
      VerificationController();
  File? frontImagePicked;
  File? backImagePicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHolder(title: widget.title),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.title == "Utility Bills" ||
                    widget.title == "Official Bank Statement")
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.ht,
                      primaryText(
                        text: "This is address verification for: ",
                        fontSize: 15.sp,
                      ),
                      20.ht,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            secondaryText(
                              text: widget.address ?? "",
                              color: Colors.black,
                            ),
                            10.ht,
                            secondaryText(
                              text: widget.city ?? "",
                              color: Colors.black,
                            ),
                            10.ht,
                            secondaryText(
                              text: widget.city ?? "",
                              color: Colors.black,
                            ),
                            10.ht,
                            secondaryText(
                              text: widget.postalCode ?? "",
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
            20.ht,
            primaryText(
              text:
                  (widget.title != "Passport" &&
                      widget.title != "Utility Bills" &&
                      widget.title != "Official Bank Statement" &&
                      widget.title != "Selfie")
                  ? "Please kindly upload a clear picture of the front and back of your ${widget.title} showing the four corners "
                  : (widget.title == "Utility Bills" ||
                        widget.title == "Official Bank Statement")
                  ? "Please kindly upload a clear picture of your  ${widget.title} not less than 3 months "
                  : (widget.title == "Selfie")
                  ? "Please take a clear, well-lit selfie with your face fully visible for verification purposes."
                  : "Please kindly upload a clear picture of your  ${widget.title} ",
              color: Colors.redAccent,
              fontSize: 14.sp,
            ),
            20.ht,
            GestureDetector(
              onTap: () async {
                if (frontImagePicked != null) {
                  final imageRepick = await ImageUploadHelper.pickAndProcess(
                    ImageSource.gallery,
                    ImageType.verification,
                  );
                  if (imageRepick != null) {
                    setState(() {
                      frontImagePicked = imageRepick;
                    });
                  }
                }
              },
              child: Container(
                width: double.infinity,
                height: 170.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: BoxBorder.all(
                    width: 3,
                    color: AppColors.primaryColor,
                  ),
                ),
                child: frontImagePicked == null
                    ? GestureDetector(
                        onTap: () async {
                          final frontFile =
                              await ImageUploadHelper.pickAndProcess(
                                ImageSource.gallery,
                                ImageType.verification,
                              );
                          if (frontFile != null) {
                            setState(() {
                              frontImagePicked = frontFile;
                            });
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined, size: 30.sp),
                            secondaryText(text: "Upload the front Image"),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10.r),
                        child: Image.file(
                          frontImagePicked!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            20.ht,
            ?(widget.title != "Passport" &&
                    widget.title != "Utility Bills" &&
                    widget.title != "Official Bank Statement" &&
                    widget.title != "Selfie")
                ? GestureDetector(
                    onTap: () async {
                      if (backImagePicked != null) {
                        final imageRepick =
                            await ImageUploadHelper.pickAndProcess(
                              ImageSource.gallery,
                              ImageType.verification,
                            );
                        if (imageRepick != null) {
                          setState(() {
                            backImagePicked = imageRepick;
                          });
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 170.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: BoxBorder.all(
                          width: 3,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: backImagePicked == null
                          ? GestureDetector(
                              onTap: () async {
                                final frontFile =
                                    await ImageUploadHelper.pickAndProcess(
                                      ImageSource.gallery,
                                      ImageType.verification,
                                    );
                                if (frontFile != null) {
                                  setState(() {
                                    backImagePicked = frontFile;
                                  });
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt_outlined, size: 30.sp),
                                  secondaryText(text: "Upload the back Image"),
                                ],
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(10.r),
                              child: Image.file(
                                backImagePicked!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  )
                : null,
            20.ht,
            GestureDetector(
              onTap: () {
                setState(() {
                  frontImagePicked = null;
                  backImagePicked = null;
                });
              },
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.lock_reset_outlined,
                      size: 30.sp,
                      color: AppColors.secondaryTextColor,
                    ),
                    secondaryText(text: "Reset Image Picked"),
                  ],
                ),
              ),
            ),
            50.ht,
            AppButton(
              text: "Submit",
              fontSize: 18.sp,
              bckColor: AppColors.primaryColor,
              textColor: Colors.white,
              width: double.infinity,
              function: () {
                _verificationController.idType = widget.title.trim();
                _verificationController.backImage = backImagePicked;
                _verificationController.frontImage = frontImagePicked;

                _verificationController.submitData(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
