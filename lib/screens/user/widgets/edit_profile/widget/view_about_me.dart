import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/about_me_controller.dart';
import 'package:neat_nest/screens/user/notifiers/about_me_controller_state.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_confirmation_button.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../../../../../widget/app_bar_holder.dart';

class ViewAboutMe extends ConsumerStatefulWidget {
  const ViewAboutMe({super.key});

  @override
  ConsumerState<ViewAboutMe> createState() => _ViewAboutMeState();
}

class _ViewAboutMeState extends ConsumerState<ViewAboutMe> {
  late AboutMeController _aboutMeController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _aboutMeController = AboutMeController();
    getAboutMe();
  }

  void getAboutMe() async {
    await _aboutMeController.getAboutMe(context, ref);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final me = ref.watch(aboutMeControllerStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(
        title: 'About MySelf',
        function: () {
          AppNavigatorHelper.push(context, AppRoute.userProfile);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.ht,
            primaryText(text: "Below is about yourself"),
            30.ht,
            isLoading
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(child: LoadingScreen()),
                  )
                : Expanded(
                    child: Stack(
                      children: [
                        me.isEmpty
                            ? Container()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.r),
                                  color: AppColors.primaryColor.withValues(
                                    alpha: 0.15,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    secondaryText(
                                      text: me.toString(),
                                      textAlign: TextAlign.justify,
                                      fontSize: 17.sp,
                                    ),
                                    20.ht,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.edit,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            size: 26.sp,
                                          ),
                                        ),
                                        10.wt,
                                        GestureDetector(
                                          onTap: () {
                                            appConfirmationButton(
                                              context: context,
                                              title: "Delete About",
                                              subTitle:
                                                  "Are you sure you want to delete about cant be reverse once delete",
                                              textButtonTextLeft: "Cancel",
                                              textButtonTextRight: "Yes",
                                              function: () async {
                                                await _aboutMeController
                                                    .deleteAboutMe(
                                                      context,
                                                      ref,
                                                    );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 26.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        me.isEmpty
                            ? Positioned(
                                bottom: 70.h,
                                left: 0,
                                right: 0,
                                child: AppButton(
                                  text: "Add About Myself",
                                  fontSize: 18.sp,
                                  bckColor: AppColors.primaryColor,
                                  textColor: Colors.white,
                                  function: () {
                                    AppNavigatorHelper.push(
                                      context,
                                      AppRoute.setAboutMe,
                                    );
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
