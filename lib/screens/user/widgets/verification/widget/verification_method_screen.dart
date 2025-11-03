import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/screens/user/notifiers/data_flow_state.dart';
import 'package:neat_nest/screens/user/utilities/verification_options_items_holder.dart';
import 'package:neat_nest/screens/user/widgets/verification/widget/Id_upload_screen.dart';
import 'package:neat_nest/screens/user/widgets/verification/widget/verification_picker_screen.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class VerificationMethodScreen extends ConsumerStatefulWidget {
  const VerificationMethodScreen({super.key});

  @override
  ConsumerState<VerificationMethodScreen> createState() =>
      _VerificationMethodScreenState();
}

class _VerificationMethodScreenState
    extends ConsumerState<VerificationMethodScreen> {
  List<String> title = [
    "ID Card Verification",
    "Address Verification",
    "Selfie Verification",
  ];

  List<String> subTitle = [
    "Government Issued ID Card",
    "Kindly Upload your Utility Bills",
    "Kindly take a selfie",
  ];

  List<IconData> icons = [
    FontAwesomeIcons.file,
    FontAwesomeIcons.locationDot,
    FontAwesomeIcons.cameraRotate,
  ];

  @override
  Widget build(BuildContext context) {
    final indent = ref.watch(dataFlowStateProvider);
    return Column(
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
            itemCount: 3,
            itemBuilder: (context, index) {
              final yes = indent[0].methodVerifyIndex == index;
              final verificationStatus = indent[index].verificationStatus;
              return GestureDetector(
                onTap: verificationStatus == "Pending"
                    ? () {
                        showErrorNotification(
                          context: context,
                          message: "Your data is under verification",
                        );
                      }
                    : () {
                        ref
                            .read(dataFlowStateProvider.notifier)
                            .updateMethodIndex(index);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              if (index < title.length - 1) {
                                return VerificationPickerScreen();
                              } else {
                                return IdUploadScreen();
                              }
                            },
                          ),
                        );
                      },
                child: VerificationOptionsItemsHolder(
                  title: title[index],
                  subTitle: subTitle[index],
                  icons: icons[index],
                  isClicked: yes,
                  textIn: verificationStatus,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
