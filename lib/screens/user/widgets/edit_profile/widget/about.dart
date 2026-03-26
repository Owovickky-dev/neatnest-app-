import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/about_me_controller.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../../widget/app_bar_holder.dart';
import '../../../../history/utilities/text_filed_holder.dart';

class About extends ConsumerStatefulWidget {
  const About({super.key, this.aboutMe});

  final String? aboutMe;

  @override
  ConsumerState<About> createState() => _AboutState();
}

class _AboutState extends ConsumerState<About> {
  late AboutMeController _aboutMeController;

  @override
  void initState() {
    super.initState();
    _aboutMeController = AboutMeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Set About MySelf'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            primaryText(
              text: "Please kindly write short brief about yourself ",
            ),
            30.ht,
            TextFiledHolder(
              titleText: 'About Ads',
              inputFormatters: [LengthLimitingTextInputFormatter(150)],
              containerHeight: 250.h,
              controller: _aboutMeController.aboutMeController,
              hintText:
                  'Write Short About Ads... only 150 character is allowed',
              textAlign: TextAlign.start,
            ),
            30.ht,
            AppButton(
              text: widget.aboutMe == null ? "Submit" : "Update",
              width: double.infinity,
              fontSize: 18.sp,
              bckColor: AppColors.primaryColor,
              textColor: Colors.white,
              function: () {
                _aboutMeController.postAboutMe(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }
}
