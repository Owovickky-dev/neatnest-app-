import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/user/notifiers/data_flow_state.dart';
import 'package:neat_nest/screens/user/notifiers/on_submit_index.dart';
import 'package:neat_nest/screens/user/widgets/verification/worker_verification_screen.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/image_upload_helper.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';
import 'package:neat_nest/widget/select_image_helper.dart';

import '../../../../../widget/app_text.dart';
import '../../../../history/utilities/app_bar_icon.dart';

class IdUploadScreen extends ConsumerStatefulWidget {
  const IdUploadScreen({super.key});

  @override
  ConsumerState<IdUploadScreen> createState() => _IdUploadScreenState();
}

class _IdUploadScreenState extends ConsumerState<IdUploadScreen> {
  List<List<String>> appBarTitle = [
    ["Passport Upload", "ID Card Upload", "Driver Licence Upload"],
    ["Utility Bills Upload", "Bank Statement Upload"],
    ["Selfie Upload"],
  ];
  File? selectedFront;
  File? selectedBack;

  late bool isLoading = false;

  List<List<String>> type = [
    ["Passport", "ID Card", "Driver License"],
    ["Utility Bills", "Bank Statement"],
    ["selfie"],
  ];

  List<String> testing = ["Aina", "Deji"];

  @override
  Widget build(BuildContext context) {
    final identity = ref.read(dataFlowStateProvider);

    final identityIndex = identity[0].identityVerifyIndex;
    final methodIndex = identity[0].methodVerifyIndex;

    String titleText;
    if (methodIndex < appBarTitle.length &&
        identityIndex < appBarTitle[methodIndex].length) {
      titleText = appBarTitle[methodIndex][identityIndex];
    } else if (methodIndex < appBarTitle.length) {
      titleText = appBarTitle[methodIndex][0]; // Use first item as fallback
    } else {
      titleText = "Upload"; // Final fallback
    }

    // SAFE TYPE ACCESS
    String documentType;
    if (methodIndex < type.length && identityIndex < type[methodIndex].length) {
      documentType = type[methodIndex][identityIndex];
    } else if (methodIndex < type.length) {
      documentType = type[methodIndex][0]; // Use first item as fallback
    } else {
      documentType = "document"; // Final fallback
    }

    // Check if this is selfie verification (methodIndex 2)
    bool isSelfie = methodIndex == 2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: primaryText(text: titleText),
        leading: AppBarIcon(
          icons: Icons.arrow_back,
          function: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              left: 20.w,
              right: 20.w,
              child: Column(
                children: [
                  10.ht,
                  secondaryText(
                    text: isSelfie
                        ? "Snap a quick selfie for identity verification Ensure your face is well-lit and visible. We'll keep it secure."
                        : "Please kindly upload a clear picture of the $documentType front and back and make sure all the data are readable",
                    color: Colors.red,
                  ),
                  10.ht,

                  // FRONT IMAGE/UPLOAD
                  ImageSelectWidget(
                    type: ImageType.verification,
                    onImageSelected: (file) {
                      setState(() {
                        selectedFront = file;
                      });
                    },
                  ),
                  20.ht,
                  // ONLY SHOW BACK UPLOAD FOR DOCUMENTS (NOT SELFIE)
                  // if (!isSelfie) ...[
                  //   20.ht,
                  //   Container(
                  //     height: 150.h,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.r),
                  //       border: Border.all(
                  //         color: AppColors.primaryColor,
                  //         width: 2,
                  //       ),
                  //       image: selectedBack != null
                  //           ? DecorationImage(
                  //               image: FileImage(selectedBack!),
                  //               fit: BoxFit.cover,
                  //             )
                  //           : null,
                  //     ),
                  //     child: selectedBack != null
                  //         ? null
                  //         : Center(
                  //             child: isLoading
                  //                 ? CircularProgressIndicator.adaptive(
                  //                     backgroundColor: AppColors.primaryColor,
                  //                   )
                  //                 : Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: [
                  //                       AppBarIcon(
                  //                         icons: Icons.add_a_photo,
                  //                         height: 60.h,
                  //                         width: 60.w,
                  //                         radius: 30.r,
                  //                         function: () =>
                  //                             showImageSource(false),
                  //                       ),
                  //                       5.ht,
                  //                       secondaryText(text: "Upload the back"),
                  //                     ],
                  //                   ),
                  //           ),
                  //   ),
                  // ],
                  if (!isSelfie)
                    ImageSelectWidget(
                      type: ImageType.verification,
                      onImageSelected: (file) {
                        setState(() {
                          selectedBack = file;
                        });
                      },
                    ),
                ],
              ),
            ),

            // RESET BUTTON
            Positioned(
              bottom: 150,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppBarIcon(
                      icons: Icons.rotate_left_sharp,
                      height: 60.h,
                      width: 60.w,
                      radius: 30.r,
                      function: () {
                        setState(() {
                          selectedBack = null;
                          selectedFront = null;
                        });
                      },
                    ),
                    5.ht,
                    secondaryText(
                      text: isSelfie
                          ? "Retake Selfie"
                          : "Reselect Your $documentType",
                    ),
                  ],
                ),
              ),
            ),

            // CONTINUE BUTTON
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 10,
              child: AppButton(
                text: "Continue",
                fontSize: 18.sp,
                bckColor: AppColors.primaryColor,
                textColor: Colors.white,
                function: () {
                  if (isSelfie) {
                    if (selectedFront == null) {
                      showErrorNotification(message: "Kindly take a selfie");
                    } else {
                      ref
                          .read(dataFlowStateProvider.notifier)
                          .updateVerificationStatus(methodIndex, "Pending");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WorkerVerificationScreen(index: 1),
                        ),
                      );
                    }
                  } else {
                    if (selectedFront == null || selectedBack == null) {
                      showErrorNotification(
                        message:
                            "Kindly Upload both the front and back of your $documentType",
                      );
                    } else {
                      ref
                          .read(onSubmitIndexProvider.notifier)
                          .updateOnSubmitIndex(methodIndex);
                      ref
                          .read(dataFlowStateProvider.notifier)
                          .updateVerificationStatus(methodIndex, "Pending");
                      print("$documentType uploaded successfully");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WorkerVerificationScreen(index: 1),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
