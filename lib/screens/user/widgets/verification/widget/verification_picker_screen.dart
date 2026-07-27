import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/screens/user/utilities/verification_options_items_holder.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';

import '../../../../../widget/app_text.dart';
import '../../../../history/utilities/app_bar_icon.dart';

class VerificationPickerScreen extends ConsumerStatefulWidget {
  const VerificationPickerScreen({super.key, required this.index});

  final int index;

  @override
  ConsumerState<VerificationPickerScreen> createState() =>
      _VerificationPickerScreenState();
}

class _VerificationPickerScreenState
    extends ConsumerState<VerificationPickerScreen> {
  int selectedIndex = 0;

  List<String> appBarTitle = [
    "ID Card Verification",
    "Address Verification",
    "Selfie Verification",
  ];
  List<List<String>> title = [
    ["Passport", "National Id", "Voter Card", "Driver License"],
    ["Utility Bills", "Official Bank Statement"],
  ];
  List<String> subTitle = [
    "International Passport",
    "Valid National Identity Card",
    "Valid Voters  Card",
    "Valid Driver License",
  ];
  List<dynamic> icons = [
    FontAwesomeIcons.passport,
    FontAwesomeIcons.idCard,
    FontAwesomeIcons.personBooth,
    FontAwesomeIcons.idCardClip,
  ];
  List<String> header = [
    "Please choose the ID Card means you'd like to use to verify your identity. ",
    "Please choose the Address Verification means you'd like to use to verify your Address. ",
    "",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: primaryText(text: appBarTitle[widget.index]),
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
                  secondaryText(text: header[widget.index], color: Colors.red),
                  20.ht,
                  Expanded(
                    child: ListView.builder(
                      itemCount: title[widget.index].length,
                      itemBuilder: (context, index) {
                        final yes = selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            AppNavigatorHelper.push(
                              context,
                              AppRoute.verificationImageUploadHelper,
                              extra: title[widget.index][index],
                            );
                          },
                          child: VerificationOptionsItemsHolder(
                            title: title[widget.index][index],
                            subTitle: subTitle[index],
                            icons: icons[index],
                            isClicked: yes,
                            textIn: "",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   left: 20.w,
            //   right: 20.w,
            //   bottom: 10,
            //   child: AppButton(
            //     text: "Continue",
            //     fontSize: 18.sp,
            //     bckColor: AppColors.primaryColor,
            //     textColor: Colors.white,
            //     function: () {
            //       setState(() {});
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
