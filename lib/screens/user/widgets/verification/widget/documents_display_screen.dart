import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/user/verificationData/user_identity_card.dart';
import 'package:neat_nest/models/verification_model.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/small_reusable_loader.dart';

import '../../../../../utilities/constant/colors.dart';
import '../../../../../utilities/constant/extension.dart';
import '../../../../../utilities/route/app_naviation_helper.dart';
import '../../../../../utilities/route/app_route_names.dart';
import '../../../../../widget/loading_screen.dart';

class DocumentsDisplayScreen extends ConsumerStatefulWidget {
  const DocumentsDisplayScreen({
    super.key,
    required this.title,
    required this.status,
  });

  final String title;
  final VerificationStatus status;

  @override
  ConsumerState<DocumentsDisplayScreen> createState() =>
      _DocumentsDisplayScreenState();
}

class _DocumentsDisplayScreenState
    extends ConsumerState<DocumentsDisplayScreen> {
  List<String> appBarTitle = [
    "ID Card Verification",
    "Address Verification",
    "Selfie Verification",
  ];

  String getDisplayMessage(
    VerificationStatus status,
    String idType, {
    String reason = "",
  }) {
    switch (status) {
      case VerificationStatus.pending:
        return "Below is your attached $idType awaiting approval";
      case VerificationStatus.approved:
        return "Below is your attached $idType approved";
        ;
      case VerificationStatus.rejected:
        return "Your $idType was rejected because $reason";
      case VerificationStatus.notStarted:
        return "Your $idType yet to start";
    }
  }

  @override
  Widget build(BuildContext context) {
    final userVerification = ref.watch(userIdentityCardProvider);
    return Scaffold(
      appBar: AppBarHolder(title: widget.title),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: userVerification.when(
          loading: () => const Center(child: LoadingScreen()),
          error: (e, _) => Center(child: secondaryText(text: e.toString())),
          data: (userDoc) {
            if (userDoc != null) {
              return Column(
                children: [
                  10.ht,
                  secondaryText(
                    text: widget.status == VerificationStatus.rejected
                        ? getDisplayMessage(
                            widget.status,
                            userDoc.title,
                            reason: userDoc.rejectedReason ?? "",
                          )
                        : getDisplayMessage(widget.status, userDoc.title),
                    color: Colors.redAccent,
                    fontSize: 16.sp,
                  ),
                  20.ht,
                  Column(
                    children: [
                      primaryText(text: "Front Image"),
                      10.ht,
                      Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(10.r),
                          border: BoxBorder.all(
                            width: 3,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: userDoc.frontImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error, color: Colors.red),
                          placeholder: (context, url) => SmallLoader(),
                        ),
                      ),
                    ],
                  ),
                  20.ht,
                  userDoc.title != "Passport"
                      ? Column(
                          children: [
                            primaryText(text: "Back Image"),
                            10.ht,
                            Container(
                              height: 200.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusGeometry.circular(
                                  10.r,
                                ),
                                border: BoxBorder.all(
                                  width: 3,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: userDoc.backImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error, color: Colors.red),
                                placeholder: (context, url) => SmallLoader(),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),

                  widget.status == VerificationStatus.rejected
                      ? Column(
                          children: [
                            20.ht,
                            AppButton(
                              text: "Re-Upload",
                              bckColor: AppColors.primaryColor,
                              fontSize: 16.sp,
                              width: double.infinity,
                              textColor: Colors.white,
                              function: () {
                                print("Resubmission clicked");
                                AppNavigatorHelper.pushReplacement(
                                  context,
                                  AppRoute.verificationPickerScreen,
                                  extra: appBarTitle.indexOf(widget.title),
                                );
                              },
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              );
            }
            return Center(
              child: primaryText(
                text: "No document found for this verification",
              ),
            );
          },
        ),
      ),
    );
  }
}
