import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../utilities/route/app_naviation_helper.dart';
import '../../../utilities/route/app_route_names.dart';
import '../../../widget/app_bar_holder.dart';
import '../../../widget/app_text.dart';
import '../widgets/row_data_holder.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Advertisement'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.ht,
              Row(
                children: [
                  Icon(FontAwesomeIcons.bookOpenReader, color: Colors.grey),
                  10.wt,
                  secondaryText(text: "Ads Activity"),
                ],
              ),
              30.ht,
              secondaryText(
                text:
                    "All action on Ads can be perform here, please kindly strictly adhere to  the platform rules to avoid your ads been suspended and account ",
                color: Colors.red.withValues(alpha: 0.8),
              ),
              30.ht,
              RowDataHolder(
                text: "Post Ads",
                icons: FontAwesomeIcons.lock,
                function: () {
                  AppNavigatorHelper.push(context, AppRoute.postAdsScreen);
                },
              ),
              30.ht,
              RowDataHolder(
                text: "View Ads",
                icons: FontAwesomeIcons.lock,
                function: () {
                  AppNavigatorHelper.push(context, AppRoute.viewAdsScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
