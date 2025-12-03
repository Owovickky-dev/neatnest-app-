import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/controller/sign_in_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/screens/user/widgets/row_data_holder.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/bottom_nav/widget/bottom_nav_notifiers.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';

import '../../utilities/app_data.dart';
import '../../widget/app_text.dart';

class UserProfileScreen extends ConsumerWidget {
  UserProfileScreen({super.key});

  final SignInController _signInController = SignInController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userControllerStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(
        title: 'Profile',
        function: () {
          ref.read(bottomNavNotifiersProvider.notifier).indexUpdate(0);
          AppNavigatorHelper.replace(context, AppRoute.bottomNavigation);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.ht,
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppColors.primaryColor,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        height: 60.r,
                        width: 60.r,
                        fit: BoxFit.cover,
                        imageUrl: AppData.imagePathway[1],
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: AppColors.primaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.person, color: Colors.white, size: 50.r),
                      ),
                    ),
                  ),
                  20.wt,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      primaryText(text: userData?.name ?? "User"),
                      secondaryText(text: userData?.username ?? "Username"),
                      ?userData?.role == "Worker"
                          ? (userData!.isVerfied!
                                ? primaryText(
                                    text: "Verified",
                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                  )
                                : primaryText(
                                    text: "Unverified",
                                    color: Colors.red,
                                    fontSize: 14.sp,
                                  ))
                          : null,
                    ],
                  ),
                ],
              ),
              30.ht,
              DottedLine(
                dashColor: AppColors.secondaryTextColor.withValues(alpha: .5),
              ),
              30.ht,
              RowDataHolder(
                text: 'Edit Profile ',
                icons: FontAwesomeIcons.pencil,
                function: () {
                  AppNavigatorHelper.push(context, AppRoute.editProfile);
                },
              ),
              20.ht,
              RowDataHolder(
                text: userData?.role == "Worker"
                    ? "Verification"
                    : 'Payment Methods',
                icons: userData?.role == "Worker"
                    ? FontAwesomeIcons.addressCard
                    : FontAwesomeIcons.creditCard,
                function: () {
                  if (userData?.role == "Worker") {
                    AppNavigatorHelper.push(
                      context,
                      AppRoute.workerVerificationScreen,
                    );
                  } else {
                    print("This is user profile");
                  }
                },
              ),
              20.ht,
              RowDataHolder(
                text: userData?.role == "Worker"
                    ? "My Account Summary"
                    : 'My booking',
                icons: Icons.calendar_month_outlined,
                function: () {},
              ),
              ?userData?.role == "Worker"
                  ? Column(
                      children: [
                        20.ht,
                        RowDataHolder(
                          text: 'My Ads',
                          icons: FontAwesomeIcons.adversal,
                          function: () {
                            AppNavigatorHelper.push(
                              context,
                              AppRoute.adsScreen,
                            );
                          },
                        ),
                      ],
                    )
                  : null,
              20.ht,
              RowDataHolder(
                text: 'Security',
                icons: Icons.security,
                function: () {
                  AppNavigatorHelper.push(context, AppRoute.securityScreen);
                },
              ),
              20.ht,
              RowDataHolder(
                text: 'Settings',
                icons: Icons.settings,
                function: () {
                  AppNavigatorHelper.push(context, AppRoute.settingsScreen);
                },
              ),
              20.ht,
              RowDataHolder(
                text: 'Help Center',
                icons: FontAwesomeIcons.hireAHelper,
                function: () {},
              ),
              30.ht,
              AppButton(
                text: "Log Out",
                bckColor: AppColors.primaryColor,
                textColor: Colors.white,
                width: double.infinity,
                fontSize: 20.sp,
                function: () => _signInController.logout(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
