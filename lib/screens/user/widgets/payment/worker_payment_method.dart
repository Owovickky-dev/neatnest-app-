import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../widget/app_bar_holder.dart';

class WorkerPaymentMethod extends StatelessWidget {
  const WorkerPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Payment Receiver Method'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            5.ht,
            secondaryText(
              text:
                  "This page will display list of your payment receiving  account ",
              color: Colors.deepOrange,
              fontSize: 16.sp,
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 40.h,
                    left: 0,
                    right: 0,
                    child: AppButton(
                      text: "Add Payment Method",
                      fontSize: 16.sp,
                      bckColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      width: double.infinity,
                      function: () {
                        AppNavigatorHelper.push(
                          context,
                          AppRoute.addPaymentMethod,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
