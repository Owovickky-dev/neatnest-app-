import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/onboarding/widgets/index_state.dart';
import 'package:neat_nest/utilities/app_data.dart';
import 'package:neat_nest/utilities/bottom_nav/bottom_navigation_screen.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int index = ref.watch(indexStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: 500,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: AppData.imagePathWelcome[index],
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator.adaptive()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: Colors.red, size: 30),
              ),
            ),
            Positioned(
              top: 400.h,
              left: 0,
              right: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 5.h, sigmaX: 5.w),
                  child: Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white.withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(top: 500, child: AppData.introScreens[index]),
            Positioned(
              bottom: 130.h,
              child: DotsIndicator(
                dotsCount: AppData.introScreens.length,
                position: index.toDouble(),
                decorator: DotsDecorator(
                  size: Size.square(9),
                  activeColor: AppColors.primaryColor,
                  activeSize: Size(20.w, 8.h),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onTap: (value) {
                  ref.read(indexStateProvider.notifier).indexUpdate(value);
                },
              ),
            ),
            Positioned(
              bottom: 50,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        AppNavigatorHelper.push(
                          context,
                          AppRoute.bottomNavigation,
                        );
                      },
                      child: primaryText(
                        text: 'skip',
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (index < 1) {
                          ref
                              .read(indexStateProvider.notifier)
                              .indexUpdate(index + 1);
                        } else {
                          debugPrint(
                            "The home page from the welcome screen us clicked",
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationScreen(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: primaryText(text: 'Next', color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
