import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/screens/user/notifiers/data_flow_state.dart';
import 'package:neat_nest/screens/user/utilities/verification_options_items_holder.dart';
import 'package:neat_nest/screens/user/widgets/verification/widget/Id_upload_screen.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../../../widget/app_text.dart';
import '../../../../history/utilities/app_bar_icon.dart';

class VerificationPickerScreen extends ConsumerStatefulWidget {
  const VerificationPickerScreen({super.key});

  @override
  ConsumerState<VerificationPickerScreen> createState() =>
      _VerificationPickerScreenState();
}

class _VerificationPickerScreenState
    extends ConsumerState<VerificationPickerScreen> {
  List<String> appBarTitle = [
    "ID Card Verification",
    "Address Verification",
    "Selfie Verification",
  ];
  List<List<String>> title = [
    ["Passport", "ID Card", "Driver Licence"],
    ["Utility Bills", "Official Bank Statement"],
    ["selfie", "selfie"],
  ];
  List<String> subTitle = [
    "International Passport",
    "NIN or Any Valid Id card",
    "Valid Driver Licence",
  ];
  List<IconData> icons = [
    FontAwesomeIcons.passport,
    FontAwesomeIcons.idCard,
    FontAwesomeIcons.idCard,
  ];
  List<String> header = [
    "Please choose the ID Card means you'd like to use to verify your identity. ",
    "Please choose the Address Verification means you'd like to use to verify your Address. ",
    "",
  ];

  @override
  Widget build(BuildContext context) {
    final methodScreen = ref.watch(dataFlowStateProvider);
    final methodeScreenIndex = methodScreen[0].methodVerifyIndex;
    final identityScreenIndex = methodScreen[0].identityVerifyIndex;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: primaryText(text: appBarTitle[methodeScreenIndex]),
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
                    text: header[methodeScreenIndex],
                    color: Colors.red,
                  ),
                  20.ht,
                  Expanded(
                    child: ListView.builder(
                      itemCount: title[methodeScreenIndex].length,
                      itemBuilder: (context, index) {
                        final yes = identityScreenIndex == index;
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(dataFlowStateProvider.notifier)
                                .updateIdentityIndex(index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => IdUploadScreen(),
                              ),
                            );
                          },
                          child: VerificationOptionsItemsHolder(
                            title: title[methodeScreenIndex][index],
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
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
