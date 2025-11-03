import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../utilities/app_button.dart';
import '../../../utilities/constant/colors.dart';
import '../../../utilities/route/app_naviation_helper.dart';
import '../../../utilities/route/app_route_names.dart';

class InRegScreen extends StatelessWidget {
  const InRegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppButton(
            text: 'Sign up',
            bckColor: AppColors.primaryColor,
            textColor: Colors.white,
            function: () {
              AppNavigatorHelper.push(context, AppRoute.signUp);
            },
            fontSize: 24.sp,
          ),
          40.ht,
          AppButton(
            text: 'Sign In',
            bckColor: AppColors.primaryColor.withValues(alpha: .1),
            textColor: AppColors.primaryColor,
            function: () {
              AppNavigatorHelper.push(context, AppRoute.signIn);
            },
            fontSize: 24.sp,
          ),
        ],
      ),
    );
  }
}
