import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state controller /favourite/favourite_state_controller.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../controller/favourite_controller.dart';
import '../../../utilities/route/app_naviation_helper.dart';
import '../../../utilities/route/app_route_names.dart';
import '../../../widget/app_text.dart';
import '../../../widget/capitalize_first_character.dart';

class FavouriteDataHolder extends ConsumerWidget {
  const FavouriteDataHolder({super.key, required this.index, this.adsModel});

  final int index;
  final AdsModel? adsModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FavouriteController favouriteController = FavouriteController();

    final ads = adsModel!;

    final favourites = ref.watch(favouriteStateControllerProvider);

    final fav = favourites.where((f) => f.adsId == ads.id).toList();

    final isFav = fav.isNotEmpty;
    final favId = isFav ? fav.first.favouriteId : null;

    return GestureDetector(
      onTap: () {
        AppNavigatorHelper.push(
          context,
          AppRoute.adsDetailsScreen,
          extra: RoutingAdsModel(
            index: index,
            isPopular: false,
            isFavourite: isFav,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.containerLightBackground,
        ),

        //  FIX: prevent overflow by using natural sizing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //  IMAGE (safe fixed height)
            SizedBox(
              width: double.infinity,
              height: 120.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: ads.imageFrmServer ?? '',
                ),
              ),
            ),

            //  CONTENT SECTION
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // USER + RATING
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: primaryText(
                          text: ads.jobPoster!.username.toUpperCase(),
                          fontSize: 12.sp,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.ratingStarColor,
                            size: 13.sp,
                          ),
                          2.wt,
                          primaryText(
                            text: ads.jobPoster!.ratingAverage.toString(),
                            fontSize: 13.sp,
                          ),
                        ],
                      ),
                    ],
                  ),

                  6.ht,

                  // TITLE
                  primaryText(
                    text: ads.title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    fontSize: 13.sp,
                  ),

                  6.ht,

                  // CATEGORY
                  secondaryText(
                    text: capitalizeFirstCharacter(ads.category),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    fontSize: 12.sp,
                  ),

                  8.ht,

                  // PRICE + FAVORITE BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          primaryText(
                            text: '\$${ads.basePrice}',
                            fontSize: 13.sp,
                          ),
                          secondaryText(text: '/hour', fontSize: 12.sp),
                        ],
                      ),

                      GestureDetector(
                        onTap: () async {
                          if (isFav) {
                            await favouriteController.removeFavourite(
                              context,
                              favId!,
                              ref,
                            );
                          } else {
                            await favouriteController.addFavourite(
                              context,
                              ads.id!,
                              ref,
                            );
                          }
                        },
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.black,
                          size: 18.sp,
                        ),
                      ),
                    ],
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
