import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/screens/booking/widgets/booking_review_holder.dart';
import 'package:neat_nest/screens/history/utilities/app_bar_icon.dart';
import 'package:neat_nest/screens/home/widget/home_screen_icons.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/app_data.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: AppData.popularImagesPath[index],
                ),
              ),
            ),
            Positioned(
              top: 40.h,
              left: 20.w,
              child: AppBarIcon(
                icons: Icons.arrow_back,
                function: () {
                  AppNavigatorHelper.back(context);
                },
              ),
            ),
            Positioned(
              top: 180.h,
              right: 0,
              left: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          primaryText(
                            text: AppData.serviceName[index],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Icon(Icons.favorite, color: Colors.red),
                        ],
                      ),
                      5.ht,
                      Row(
                        children: [
                          secondaryText(
                            text: AppData.serviceProviderName[index],
                          ),
                          5.wt,
                          secondaryText(text: '|'),
                          5.wt,
                          Icon(
                            Icons.star,
                            size: 12.sp,
                            color: AppColors.ratingStarColor,
                          ),
                          secondaryText(
                            text: '4.2',
                            color: AppColors.ratingStarColor,
                            fontSize: 10.sp,
                          ),
                          3.wt,
                          secondaryText(text: "(530 Reviews)", fontSize: 10.sp),
                        ],
                      ),
                      20.ht,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              primaryText(text: "Joined:", fontSize: 16.sp),
                              10.wt,
                              secondaryText(
                                text: "Sept, 2025",
                                fontSize: 16.sp,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              HomeScreenIcons(
                                icons: Icons.location_on,
                                text: "Nigeria, Osun",
                              ),
                              10.wt,
                              HomeScreenIcons(
                                icons: Icons.share,
                                text: "share",
                              ),
                            ],
                          ),
                        ],
                      ),
                      20.ht,
                      primaryText(text: "About the service"),
                      10.ht,
                      secondaryText(
                        textAlign: TextAlign.justify,
                        text:
                            "I am a professional Reliable house cleaner with experience in deep cleaning, dusting, mopping, and home organization. Detail-oriented, efficient, and committed to keeping your space fresh and spotless.",
                      ),
                      20.ht,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10.w, top: 10.h),
                            height: 70.h,
                            width: MediaQuery.of(context).size.width * 0.42,
                            decoration: BoxDecoration(
                              color: AppColors.containerLightBackground,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                primaryText(text: "200k +"),
                                secondaryText(text: "Happy Customer"),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.w, top: 10.h),
                            height: 70.h,
                            width: MediaQuery.of(context).size.width * 0.42,
                            decoration: BoxDecoration(
                              color: AppColors.containerLightBackground,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                primaryText(text: "99 %"),
                                secondaryText(text: "client Satisfaction"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      10.ht,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          primaryText(text: "Reviews"),
                          TextButton(
                            onPressed: () {
                              debugPrint("ViewAll Clicked");
                            },
                            child: secondaryText(
                              text: "View All",
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 150.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return BookingReviewHolder(index: index);
                          },
                        ),
                      ),
                      15.ht,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              primaryText(text: "\$1,600"),
                              secondaryText(text: "/hour", fontSize: 11.sp),
                            ],
                          ),
                          AppButton(
                            text: "Book now",
                            verticalHeight: 12,
                            fontSize: 14,
                            bckColor: AppColors.primaryColor,
                            textColor: Colors.white,
                            function: () {
                              debugPrint("Booking clicked");
                              AppNavigatorHelper.push(
                                context,
                                AppRoute.bookingFormScreen,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
