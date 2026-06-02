import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/controller/state%20controller%20/address/address_state_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/popular_service_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/models/booking_navigation_args.dart';
import 'package:neat_nest/screens/booking/widgets/booking_review_holder.dart';
import 'package:neat_nest/screens/history/utilities/app_bar_icon.dart';
import 'package:neat_nest/screens/home/widget/home_screen_icons.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/widget/app_confirmation_button.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../../controller/state controller /ads/ads_state_controller.dart';
import '../../utilities/route/app_route_names.dart';
import '../../widget/capitalize_first_character.dart';

class AdsDetailsScreen extends ConsumerStatefulWidget {
  const AdsDetailsScreen({
    super.key,
    required this.index,
    required this.isFavourite,
    required this.isPopularAds,
  });

  final int index;
  final bool isFavourite;
  final bool isPopularAds;

  @override
  ConsumerState<AdsDetailsScreen> createState() => _AdsDetailsScreenState();
}

class _AdsDetailsScreenState extends ConsumerState<AdsDetailsScreen> {
  late PageController pageController;

  int currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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
                  extra: widget.index,
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
  Widget build(BuildContext context) {
    final adsList = ref.watch(adsStateControllerProvider);
    final popularList = ref.watch(popularServiceControllerProvider);
    final addressExist = ref.watch(addressStateControllerProvider);
    final ads = widget.isPopularAds ? popularList : adsList;
    final adsInfo = ads[widget.index];
    final posterJoinedDate = adsInfo.jobPoster!.joinedAt;
    final user = ref.watch(userControllerStateProvider);
    final myDate = DateTime.parse(posterJoinedDate!).toLocal();

    final myDateFormat = DateFormat("MMMM, yyyy").format(myDate);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300.h,
              child: PageView.builder(
                controller: pageController,
                itemCount: adsInfo.imageFrmServer?.length ?? 0,
                onPageChanged: (index) {
                  setState(() {
                    currentImageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: adsInfo.imageFrmServer![index].imageUrl,
                    ),
                  );
                },
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
              top: 220.h,
              right: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: secondaryText(
                  text:
                      "${currentImageIndex + 1}/${adsInfo.imageFrmServer?.length ?? 0}",
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
            ),

            Positioned(
              top: 290.h,
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
                      10.ht,

                      Center(
                        child: DotsIndicator(
                          position: currentImageIndex.toDouble(),
                          dotsCount: adsInfo.imageFrmServer?.length ?? 0,
                          decorator: DotsDecorator(
                            size: Size.square(9),
                            activeColor: AppColors.primaryColor,
                            activeSize: Size(20.w, 8.h),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),

                      10.ht,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          primaryText(
                            text: adsInfo.title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),

                          Icon(
                            widget.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.isFavourite
                                ? Colors.red
                                : Colors.black,
                          ),
                        ],
                      ),

                      5.ht,

                      secondaryText(
                        text: capitalizeFirstCharacter(adsInfo.category),
                        fontSize: 20.sp,
                      ),

                      5.ht,

                      Row(
                        children: [
                          secondaryText(
                            text: capitalizeFirstCharacter(
                              adsInfo.jobPoster!.username,
                            ),
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
                            icons: FontAwesomeIcons.locationDot,
                            text: adsInfo.country!.isNotEmpty
                                ? "${adsInfo.country}, ${adsInfo.state}"
                                : " No location",
                          ),

                          10.wt,

                          HomeScreenIcons(
                            icons: FontAwesomeIcons.shareNodes,
                            text: "share",
                          ),
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
                                  message: "You can't book your own ads",
                                );
                              } else {
                                appConfirmationButton(
                                  context: context,
                                  title: "Book Ads",
                                  subTitle: "Who is the Booking for?",
                                  textButtonTextLeft: "MYSELF",
                                  textButtonTextRight: "OTHER",

                                  functionRight: () {
                                    AppNavigatorHelper.push(
                                      context,
                                      AppRoute.bookingFormScreen,
                                      extra: BookingNavigationArgs(
                                        isMe: false,
                                        index: widget.index,
                                        isPopularAds: widget.isPopularAds,
                                      ),
                                    );
                                  },

                                  functionLeft: () {
                                    context.pop();

                                    if (addressExist.isNotEmpty) {
                                      AppNavigatorHelper.push(
                                        context,
                                        AppRoute.bookingFormScreen,
                                        extra: BookingNavigationArgs(
                                          isMe: true,
                                          index: widget.index,
                                          isPopularAds: widget.isPopularAds,
                                        ),
                                      );
                                    } else {
                                      showSuccessNotification(
                                        message:
                                            "You don't have any exist address please fill in details",
                                      );

                                      AppNavigatorHelper.push(
                                        context,
                                        AppRoute.bookingFormScreen,
                                        extra: BookingNavigationArgs(
                                          isMe: false,
                                          index: widget.index,
                                          isPopularAds: widget.isPopularAds,
                                        ),
                                      );
                                    }
                                  },
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
