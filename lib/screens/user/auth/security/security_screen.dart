import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/screens/user/widgets/row_data_holder.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../utilities/route/app_naviation_helper.dart';
import '../../../../utilities/route/app_route_names.dart';
import '../../../../widget/app_bar_holder.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Security'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.ht,
              Row(
                children: [
                  Icon(FontAwesomeIcons.userShield, color: Colors.grey),
                  10.wt,
                  secondaryText(text: "Account Activity"),
                ],
              ),
              30.ht,
              secondaryText(
                text:
                    "Please make sure you use secure details and what know personal to you for your password and withdrawal password",
                color: Colors.red.withValues(alpha: 0.8),
              ),
              30.ht,
              Row(
                children: [
                  secondaryText(text: "Security Level"),
                  20.wt,
                  secondaryText(
                    text: "High ---",
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              30.ht,
              RowDataHolder(
                text: "Change Password",
                icons: FontAwesomeIcons.lock,
                function: () {
                  AppNavigatorHelper.push(
                    context,
                    AppRoute.updatePasswordScreen,
                  );
                },
              ),
              30.ht,
              RowDataHolder(
                text: "Change Email",
                icons: Icons.mail,
                function: () {},
              ),
              30.ht,
              RowDataHolder(
                text: "Change Phone Number",
                icons: Icons.phone,
                function: () {},
              ),
              20.ht,
              RowDataHolder(
                text: "Withdrawal Password",
                icons: Icons.lock_clock,
                function: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
