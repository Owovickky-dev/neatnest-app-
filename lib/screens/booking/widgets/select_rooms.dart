import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/booking/utilities/select_address_container.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../widget/app_text.dart';
import '../../history/utilities/app_bar_icon.dart';

class SelectRooms extends ConsumerWidget {
  const SelectRooms({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 40.h),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: primaryText(text: "Select Rooms"),
          leading: AppBarIcon(
            icons: Icons.arrow_back_ios,
            function: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            20.ht,
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return SelectRoomsContainer(index: index);
                },
              ),
            ),
            20.ht,
            AppButton(
              width: double.infinity,
              text: "Continue",
              fontSize: 20.sp,
              bckColor: AppColors.primaryColor,
              textColor: Colors.white,
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Container()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
