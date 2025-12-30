import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/favourite_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/favourite/favourite_state_controller.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/screens/booking/booking_screen.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../widget/app_text.dart';

class FavouriteDataHolder extends ConsumerStatefulWidget {
  const FavouriteDataHolder({super.key, required this.index, this.adsModel});

  final int index;
  final AdsModel? adsModel;

  @override
  ConsumerState<FavouriteDataHolder> createState() =>
      _FavouriteDataHolderState();
}

class _FavouriteDataHolderState extends ConsumerState<FavouriteDataHolder> {
  final FavouriteController _favouriteController = FavouriteController();

  String capitalizeFirst(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  String? getFavId(String adsId) {
    final adsFav = ref.watch(favouriteStateControllerProvider);
    try {
      final matchId = adsFav.firstWhere((fav) => fav.adsId == adsId);
      return matchId.favouriteId;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ads = widget.adsModel!;
    final favId = getFavId(ads.id!);
    final isFav = favId != null;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BookingScreen(index: widget.index, isFavourite: isFav),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.containerLightBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 130.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.r),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: ads.image ?? '',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: primaryText(
                          text: ads.title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          fontSize: 15.sp,
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
                  primaryText(
                    text: ads.jobPoster!.username.toUpperCase(),
                    fontSize: 12.sp,
                  ),
                  6.ht,
                  secondaryText(
                    text: capitalizeFirst(ads.category),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    fontSize: 12.sp,
                  ),

                  8.ht,

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
                            await _favouriteController.removeFavourite(
                              context,
                              favId,
                              ref,
                            );
                          } else {
                            await _favouriteController.addFavourite(
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
