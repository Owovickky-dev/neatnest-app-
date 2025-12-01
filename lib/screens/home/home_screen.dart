import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neat_nest/controller/filter_search_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/screens/home/filter/notifier/filter_state.dart';
import 'package:neat_nest/screens/home/notifier/home_display_data_state.dart';
import 'package:neat_nest/screens/home/utilities/home_screen_index_state.dart';
import 'package:neat_nest/screens/home/widget/all_ads_screen.dart';
import 'package:neat_nest/screens/home/widget/home_screen_icons.dart';
import 'package:neat_nest/screens/home/widget/popula_service_images.dart';
import 'package:neat_nest/screens/home/widget/searching_screen.dart';
import 'package:neat_nest/utilities/app_data.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/app_text_field.dart';

import '../../utilities/constant/colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late PageController pageController;
  late FilterSearchController filterSearchController;
  late Timer _timer;
  bool isSearchingData = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    filterSearchController = FilterSearchController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoScroll({bool homePageDisplayAll = false}) {
    if (homePageDisplayAll) return;
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (ref.read(homeScreenIndexStateProvider) == -1) {
        return;
      }

      if (!pageController.hasClients) return;
      final nextPage =
          ref.read(homeScreenIndexStateProvider) <
              AppData.imagePathway.length - 1
          ? ref.read(homeScreenIndexStateProvider) + 1
          : 0;

      pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int index) {
    ref.read(homeScreenIndexStateProvider.notifier).homeIndexUpdate(index);
    _timer.cancel();
    _startAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    final indexProv = ref.watch(homeScreenIndexStateProvider);
    final homePageDisplay = ref.watch(homeDisplayDataStateProvider);
    final userData = ref.watch(userControllerStateProvider);
    final debouncer = Debouncer(delay: Duration(milliseconds: 500));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userData != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: CachedNetworkImage(
                                  height: 40.h,
                                  width: 40.w,
                                  placeholder: (context, url) => Container(
                                    height: 40.h,
                                    width: 40.w,
                                    color: Colors.grey.shade200,
                                    child: CircularProgressIndicator.adaptive(
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        color: Colors.grey.shade200,
                                        child: Icon(
                                          Icons.person,
                                          size: 40.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                  fit: BoxFit.cover,
                                  fadeInDuration: Duration(milliseconds: 500),
                                  fadeOutDuration: Duration(milliseconds: 300),
                                  imageUrl:
                                      'https://media.hswstatic.com/eyJidWNrZXQiOiJjb250ZW50Lmhzd3N0YXRpYy5jb20iLCJrZXkiOiJnaWZcL3BsYXlcLzBiN2Y0ZTliLWY1OWMtNDAyNC05ZjA2LWIzZGMxMjg1MGFiNy0xOTIwLTEwODAuanBnIiwiZWRpdHMiOnsicmVzaXplIjp7IndpZHRoIjo4Mjh9fX0=',
                                ),
                              ),
                              10.wt,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  secondaryText(
                                    text:
                                        'hi, ${userData.username.toUpperCase()}',
                                    fontSize: 12,
                                  ),
                                  primaryText(
                                    text: 'Osun, Nigeria',
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              AppNavigatorHelper.push(
                                context,
                                AppRoute.notification,
                              );
                            },
                            child: Stack(
                              children: [
                                Icon(Icons.notifications_none),
                                Positioned(
                                  left: 13.w,
                                  top: 1.h,
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Center(
                                      child: secondaryText(
                                        text: '2',
                                        fontSize: 5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : SizedBox(height: 10.h),
                5.ht,
                AppTextField(
                  hintText: 'Search  by category only...',
                  iconPrefix: Icons.search,
                  iconSuffix: Icons.menu,
                  onChanged: (value) {
                    print(value);
                    ref
                        .read(homeDisplayDataStateProvider.notifier)
                        .displayData(true);
                    if (value.isNotEmpty) {
                      setState(() {
                        isSearchingData = true;
                      });
                    }

                    ref.read(filterStateProvider.notifier).reset();
                    ref.read(filterStateProvider.notifier).setCategory(value);
                    debouncer(() {
                      filterSearchController.submit(context, ref);
                    });
                  },
                  function: () {
                    AppNavigatorHelper.push(context, AppRoute.filterData);
                  },
                ),
                10.ht,
                Expanded(
                  child: homePageDisplay
                      ? isSearchingData
                            ? SearchingScreen()
                            : AllAdsScreen()
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              primaryText(text: 'Special Offer'),
                              10.ht,
                              SizedBox(
                                height: 170.h,
                                child: PageView.builder(
                                  controller: pageController,
                                  onPageChanged: _onPageChanged,
                                  itemCount: AppData.imagePathway.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(left: 10.w),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: AppData.imagePathway[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              10.ht,
                              Center(
                                child: DotsIndicator(
                                  position: indexProv.toDouble(),
                                  dotsCount: AppData.imagePathway.length,
                                  decorator: DotsDecorator(
                                    size: Size.square(9),
                                    activeColor: AppColors.primaryColor,
                                    activeSize: Size(20.w, 8.h),
                                    activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onTap: (value) {
                                    ref
                                        .read(
                                          homeScreenIndexStateProvider.notifier,
                                        )
                                        .homeIndexUpdate(value.toInt());
                                    ref
                                        .read(
                                          homeScreenIndexStateProvider.notifier,
                                        )
                                        .toggleAutoScroll(false);
                                    pageController.jumpToPage(value);
                                  },
                                ),
                              ),
                              10.ht,
                              primaryText(text: 'Categories'),
                              10.ht,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  HomeScreenIcons(
                                    text: 'Cleaning',
                                    icons: FontAwesomeIcons.broom,
                                  ),
                                  5.wt,
                                  HomeScreenIcons(
                                    text: 'Repairing',
                                    icons: FontAwesomeIcons.hammer,
                                  ),
                                  5.wt,
                                  HomeScreenIcons(
                                    text: 'Painting',
                                    icons: FontAwesomeIcons.paintRoller,
                                  ),
                                  5.wt,
                                  HomeScreenIcons(
                                    text: 'More',
                                    icons: Icons.apps,
                                  ),
                                  5.wt,
                                ],
                              ),
                              10.ht,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  primaryText(
                                    text: 'Popular Services',
                                    fontSize: 18.sp,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _startAutoScroll(
                                        homePageDisplayAll: true,
                                      );
                                      ref
                                          .read(
                                            homeDisplayDataStateProvider
                                                .notifier,
                                          )
                                          .displayData(true);
                                      print("Home page display all is clicked");
                                    },
                                    child: secondaryText(
                                      text: 'view all',
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              10.ht,
                              SizedBox(
                                height: 130.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: AppData.popularImagesPath.length,
                                  itemBuilder: (context, index) {
                                    return PopulaServiceImages(
                                      imagePath:
                                          AppData.popularImagesPath[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Debouncer {
  Debouncer({required this.delay});
  final Duration delay;

  Timer? _timer;

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
