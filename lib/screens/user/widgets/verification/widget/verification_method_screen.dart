import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/models/verification_model.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_notification.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../../../../../controller/state controller /user/user_verification_state.dart';

class VerificationMethodScreen extends ConsumerStatefulWidget {
  const VerificationMethodScreen({super.key});

  @override
  ConsumerState<VerificationMethodScreen> createState() =>
      _VerificationMethodScreenState();
}

class _VerificationMethodScreenState
    extends ConsumerState<VerificationMethodScreen> {
  int selectedIndex = 0;

  FaIcon getIconStatus(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.approved:
        return FaIcon(
          FontAwesomeIcons.circleCheck,
          color: AppColors.primaryColor,
          size: 30.sp,
        );

      case VerificationStatus.pending:
        return FaIcon(
          FontAwesomeIcons.spinner,
          color: Colors.orangeAccent,
          size: 30.sp,
        );

      case VerificationStatus.rejected:
        return FaIcon(
          FontAwesomeIcons.circleXmark,
          color: Colors.red,
          size: 30.sp,
        );
        ;

      case VerificationStatus.notStarted:
        return FaIcon(
          FontAwesomeIcons.hourglassStart,
          color: AppColors.secondaryTextColor,
          size: 30.sp,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final verificationAsync = ref.watch(userVerificationStateProvider);
    return Scaffold(
      appBar: AppBarHolder(title: "Verification Method"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: verificationAsync.when(
          loading: () => const Center(child: LoadingScreen()),
          error: (e, _) => Center(child: secondaryText(text: e.toString())),
          data: (verification) {
            if (verification != null) {
              final methods = [
                VerificationMethod(
                  title: "ID Card Verification",
                  subTitle: "Government Issued ID Card",
                  icon: FontAwesomeIcons.idCard,
                  status: verification.idVerification,
                ),
                VerificationMethod(
                  title: "Address Verification",
                  subTitle: "Kindly Upload your Utility Bills",
                  icon: FontAwesomeIcons.locationDot,
                  status: verification.addressVerification,
                ),
                VerificationMethod(
                  title: "Selfie Verification",
                  subTitle: "Kindly take a selfie",
                  icon: FontAwesomeIcons.cameraRotate,
                  status: verification.selfieVerification,
                ),
                VerificationMethod(
                  title: "Skills Verification",
                  subTitle: "Kindly verify your skills",
                  icon: FontAwesomeIcons.wirsindhandwerk,
                  status: verification.skillsVerification,
                ),
              ];

              return Column(
                children: [
                  20.ht,
                  secondaryText(
                    text:
                        "Kindly pick the verification method you want to kick start, please kindly note only valid document is require",
                    color: Colors.redAccent,
                  ),
                  20.ht,
                  Expanded(
                    child: ListView.builder(
                      itemCount: methods.length,
                      itemBuilder: (context, index) {
                        final item = methods[index];
                        final current = selectedIndex == index;

                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              selectedIndex = index;
                            });

                            if (index == 2) {
                              AppNavigatorHelper.push(
                                context,
                                AppRoute.verificationImageUploadHelper,
                                extra: "Selfie",
                              );
                            } else {
                              if (item.status == VerificationStatus.approved) {
                                showSuccessNotification(
                                  message: "Already Verified",
                                );
                                AppNavigatorHelper.push(
                                  context,
                                  AppRoute.documentDisplayScreen,
                                  extra: item.title,
                                );
                              } else {
                                AppNavigatorHelper.push(
                                  context,
                                  AppRoute.verificationPickerScreen,
                                  extra: index,
                                );
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: current ? Colors.grey.shade200 : null,
                              border: Border.all(
                                width: 2,
                                color: current
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    color: AppColors.primaryColor.withValues(
                                      alpha: 0.25,
                                    ),
                                  ),
                                  child: Center(
                                    child: FaIcon(
                                      item.icon,
                                      size: 24,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),

                                10.wt,

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      primaryText(
                                        text: item.title,
                                        fontSize: 16.sp,
                                      ),
                                      secondaryText(
                                        text: item.subTitle,
                                        fontSize: 12.sp,
                                      ),
                                    ],
                                  ),
                                ),

                                getIconStatus(item.status),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
