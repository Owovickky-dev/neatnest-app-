import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/screens/user/widgets/row_data_holder.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../../../../widget/app_text.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  Future<void> _handleSave(BuildContext context) async {
    showSuccessNotification(message: "Changes saved successfully");
    await Future.delayed(Duration(seconds: 2));
    if (context.mounted) {
      AppNavigatorHelper.replace(context, AppRoute.userProfile);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Edit Profile'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.r),
                  ),
                ),

                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    "https://www.shutterstock.com/image-photo/handsome-happy-african-american-bearded-260nw-2460702995.jpg",
                              ),
                            ),
                          ),
                          10.ht,
                          primaryText(text: "Owovickky"),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 35.h,
                      right: 90.w,
                      child: GestureDetector(
                        onTap: () {
                          print("Photo Editing Clicked");
                        },
                        child: Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: AppColors.primaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.ht,
              DottedLine(
                dashColor: AppColors.primaryColor.withValues(alpha: .5),
              ),
              10.ht,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    RowDataHolder(
                      text: 'Personal Information',
                      icons: Icons.person,
                      function: () {
                        AppNavigatorHelper.push(
                          context,
                          AppRoute.personalInfoEdit,
                        );
                      },
                    ),
                    15.ht,
                    RowDataHolder(
                      text: 'Payment Methods',
                      icons: FontAwesomeIcons.buildingColumns,
                      function: () {
                        user?.role == "Worker"
                            ? AppNavigatorHelper.push(
                                context,
                                AppRoute.workerPaymentMethod,
                              )
                            : AppNavigatorHelper.push(
                                context,
                                AppRoute.userPaymentMethod,
                              );
                      },
                    ),
                    15.ht,
                    RowDataHolder(
                      text: 'Address Information',
                      icons: FontAwesomeIcons.locationDot,
                      function: () {
                        AppNavigatorHelper.push(
                          context,
                          AppRoute.userAddresses,
                        );
                      },
                    ),
                    15.ht,
                    RowDataHolder(
                      text: 'About MySelf',
                      icons: FontAwesomeIcons.user,
                      function: () {},
                    ),
                    30.ht,
                    AppButton(
                      text: "Save All Changes",
                      fontSize: 18.sp,
                      bckColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      width: double.infinity,
                      function: () => _handleSave(context),
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
