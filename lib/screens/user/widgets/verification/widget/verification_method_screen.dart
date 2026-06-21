import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/screens/user/widgets/verification/widget/verification_picker_screen.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';

class VerificationMethodScreen extends ConsumerStatefulWidget {
  const VerificationMethodScreen({super.key});

  @override
  ConsumerState<VerificationMethodScreen> createState() =>
      _VerificationMethodScreenState();
}

class _VerificationMethodScreenState
    extends ConsumerState<VerificationMethodScreen> {
  int selectedIndex = 0;

  List<String> title = [
    "ID Card Verification",
    "Address Verification",
    "Selfie Verification",
    "Skills Verification",
  ];

  List<String> subTitle = [
    "Government Issued ID Card",
    "Kindly Upload your Utility Bills",
    "Kindly take a selfie",
    "Kindly verify your skills",
  ];

  List<FaIconData> icons = [
    FontAwesomeIcons.idCard,
    FontAwesomeIcons.locationDot,
    FontAwesomeIcons.cameraRotate,
    FontAwesomeIcons.wirsindhandwerk,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHolder(title: "Verification Method"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.ht,
            secondaryText(
              text:
                  "Kindly Kick start your verification, below is the verification required ",
              color: Colors.red,
            ),
            20.ht,
            Expanded(
              child: ListView.builder(
                itemCount: title.length,
                itemBuilder: (context, index) {
                  final current = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });

                      if (index == 2) {
                        print("it selfie");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                VerificationPickerScreen(index: index),
                          ),
                        );
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
                        border: BoxBorder.all(
                          width: 2,
                          color: current ? AppColors.primaryColor : Colors.grey,
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
                                icons[index],
                                size: 24,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          10.wt,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                primaryText(
                                  text: title[index],
                                  fontSize: 16.sp,
                                ),
                                secondaryText(
                                  text: subTitle[index],
                                  fontSize: 12.sp,
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.pending_outlined,
                            size: 28,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
