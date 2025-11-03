import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/user/widgets/verification/widget/verification_method_screen.dart';
import 'package:neat_nest/screens/user/widgets/verification/widget/verification_start_screen.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';

class WorkerVerificationScreen extends StatefulWidget {
  const WorkerVerificationScreen({super.key, this.index = 0});
  final int index;

  @override
  State<WorkerVerificationScreen> createState() =>
      _WorkerVerificationScreenState();
}

class _WorkerVerificationScreenState extends State<WorkerVerificationScreen> {
  late int index = widget.index;

  List<Widget> pages = [VerificationStartScreen(), VerificationMethodScreen()];

  List<String> buttonText = ["Start", "Continue"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: "Identity Verification"),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(left: 20.w, right: 20.w, child: pages[index]),
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 10,
              child: AppButton(
                text: buttonText[index],
                fontSize: 18.sp,
                bckColor: AppColors.primaryColor,
                textColor: Colors.white,
                function: () {
                  setState(() {
                    if (index < pages.length - 1) {
                      index++;
                    } else {
                      index = 0;
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
