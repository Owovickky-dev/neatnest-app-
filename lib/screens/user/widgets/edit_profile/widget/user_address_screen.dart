import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../../utilities/app_button.dart';
import '../../../../../utilities/constant/colors.dart';
import '../../../../../widget/app_bar_holder.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Addresses'),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ht,
              secondaryText(
                text: "Below is the list of your addresses",
                fontSize: 18.sp,
              ),
              20.ht,
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100.h,
                          child: Text("My address"),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 40.h,
                      left: 0,
                      right: 0,
                      child: AppButton(
                        text: "Add Address",
                        fontSize: 16.sp,
                        bckColor: AppColors.primaryColor,
                        textColor: Colors.white,
                        width: double.infinity,
                        function: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
