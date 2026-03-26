import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/favourite/favourite_state_controller.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/screens/favorite/widgets/favourite_data_template.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../../utilities/bottom_nav/bottom_navigation_screen.dart';
import '../../utilities/bottom_nav/widget/bottom_nav_notifiers.dart';
import '../../utilities/route/app_naviation_helper.dart';
import '../../utilities/route/app_route_names.dart';
import '../../widget/app_text.dart';
import '../history/utilities/app_bar_icon.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  bool isLoading = true;
  bool isLoggedIn = false;
  bool isCheckingLogin = true;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    final userDataExist = await SecureStorageHelper.isDataStored();
    if (!mounted) return;
    setState(() {
      isLoggedIn = userDataExist;
      isCheckingLogin = false;
    });

    if (userDataExist) {
      await ref
          .read(favouriteStateControllerProvider.notifier)
          .getUserFavourite();

      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userFavourites = ref.watch(favouriteStateControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: primaryText(text: 'Favorite'),
        leading: Consumer(
          builder: (context, ref, _) {
            return AppBarIcon(
              icons: Icons.arrow_back,
              function: () {
                ref.read(bottomNavNotifiersProvider.notifier).indexUpdate(0);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen(),
                  ),
                );
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.ht,
            primaryText(
              text: "You can only have maximum 20 favourite list",
              color: Colors.red,
              fontSize: 14.sp,
            ),
            !isLoggedIn
                ? Center(
                    child: Column(
                      children: [
                        30.ht,
                        Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: AppColors.primaryColor,
                              size: 30.sp,
                            ),
                          ),
                        ),
                        15.ht,
                        secondaryText(
                          text: "Please sign in to access this content",
                          color: Colors.black,
                        ),
                        15.ht,
                        secondaryText(
                          text: "if you are not registered just sign up ",
                        ),
                        30.ht,
                        AppButton(
                          text: "Sign  In",
                          fontSize: 15.sp,
                          width: double.infinity,
                          bckColor: AppColors.primaryColor,
                          textColor: Colors.white,
                          function: () {
                            AppNavigatorHelper.push(context, AppRoute.signIn);
                          },
                        ),
                      ],
                    ),
                  )
                : isLoading
                ? Expanded(child: LoadingScreen())
                : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.ht,
                        primaryText(
                          text: "Favourite List  (${userFavourites.length})",
                        ),
                        20.ht,
                        userFavourites.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: userFavourites.length,
                                  itemBuilder: (context, index) {
                                    final userFavourite = userFavourites[index];
                                    return FavouriteDataTemplate(
                                      title: userFavourite.adsModel!.title!,
                                      adsOwner: userFavourite
                                          .adsModel!
                                          .jobPoster!
                                          .username,
                                      price: userFavourite.adsModel!.basePrice!,
                                      image: userFavourite.adsModel!.image!,
                                      favId: userFavourite.favouriteId!,
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: primaryText(
                                  text: "You don't have any favourite yet",
                                  color: Colors.grey,
                                ),
                              ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
