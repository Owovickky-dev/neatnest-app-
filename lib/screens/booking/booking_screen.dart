import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/screens/booking/widgets/booking_review_holder.dart';
import 'package:neat_nest/screens/history/utilities/app_bar_icon.dart';
import 'package:neat_nest/screens/home/widget/home_screen_icons.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../../controller/state controller /ads/ads_state_controller.dart';
import '../../utilities/route/app_route_names.dart';

class BookingScreen extends ConsumerWidget {
  const BookingScreen({
    super.key,
    required this.index,
    required this.isFavourite,
  });
  final int index;
  final bool isFavourite;
  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: primaryText(text: "Sign in"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [secondaryText(text: "Do you want to login")],
          ),
          actions: [
            TextButton(
              onPressed: () {
                dialogContext.pop();
              },
              child: secondaryText(text: "Cancel"),
            ),
            TextButton(
              onPressed: () async {
                dialogContext.pop();
                AppNavigatorHelper.push(
                  dialogContext,
                  AppRoute.signIn,
                  extra: index,
                );
              },
              child: secondaryText(text: "Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adsList = ref.watch(adsStateControllerProvider);
    final adsInfo = adsList[index];
    final posterJoinedDate = adsInfo.jobPoster!.joinedAt;
    final user = ref.watch(userControllerStateProvider);
    final myDate = DateTime.parse(posterJoinedDate!).toLocal();
    final myDateFormat = DateFormat("MMMM, yyyy").format(myDate);
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
                  imageUrl: adsInfo.image!,
                ),
              ),
            ),
            Positioned(
              top: 40.h,
              left: 20.w,
              child: AppBarIcon(
                icons: Icons.arrow_back,
                function: () {
                  context.pop();
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
                            text: adsInfo.title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Icon(
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavourite ? Colors.red : Colors.black,
                          ),
                        ],
                      ),
                      5.ht,
                      Row(
                        children: [
                          secondaryText(text: adsInfo.jobPoster!.username),
                          5.wt,
                          secondaryText(text: '|'),
                          5.wt,
                          Icon(
                            Icons.star,
                            size: 12.sp,
                            color: AppColors.ratingStarColor,
                          ),
                          secondaryText(
                            text: adsInfo.jobPoster!.ratingAverage.toString(),
                            color: AppColors.ratingStarColor,
                            fontSize: 10.sp,
                          ),
                          3.wt,
                          secondaryText(text: "(530 Reviews)", fontSize: 10.sp),
                        ],
                      ),
                      20.ht,
                      Row(
                        children: [
                          primaryText(text: "Joined:", fontSize: 14.sp),
                          10.wt,
                          secondaryText(text: myDateFormat, fontSize: 13.sp),
                        ],
                      ),
                      20.ht,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomeScreenIcons(
                            icons: Icons.location_on,
                            text: "${adsInfo.country}, ${adsInfo.state}",
                          ),
                          10.wt,
                          HomeScreenIcons(icons: Icons.share, text: "share"),
                        ],
                      ),
                      20.ht,
                      primaryText(text: "About the service"),
                      10.ht,
                      secondaryText(
                        textAlign: TextAlign.justify,
                        text: adsInfo.about!,
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
                            return BookingReviewHolder(index: 1);
                          },
                        ),
                      ),
                      15.ht,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              primaryText(text: "\$${adsInfo.basePrice}"),
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
                              final isUser = user?.id == adsInfo.jobPoster!.id;
                              if (user == null) {
                                showErrorNotification(
                                  message: "Please kindly login to book ",
                                );
                                showConfirmationDialog(context);
                              } else if (isUser == true) {
                                showErrorNotification(
                                  message: "You can't pick your own ads",
                                );
                              } else {
                                AppNavigatorHelper.push(
                                  context,
                                  AppRoute.bookingFormScreen,
                                  extra: index,
                                );
                              }
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
