import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/favourite_controller.dart';
import '../../../controller/state controller /favourite/favourite_state_controller.dart';
import '../../../models/ads_model.dart';
import '../../../utilities/constant/colors.dart';
import '../../../utilities/constant/extension.dart';
import '../../../widget/app_text.dart';
import '../../booking/booking_screen.dart';

class PopularService extends ConsumerStatefulWidget {
  const PopularService({super.key, required this.index, this.adsModel});

  final int index;
  final AdsModel? adsModel;

  @override
  ConsumerState<PopularService> createState() => _PopularServiceState();
}

class _PopularServiceState extends ConsumerState<PopularService> {
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
    // ========== SAFETY CHECK ==========
    if (widget.adsModel == null) {
      return Container(
        width: 200.w,
        height: 130.h,
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.grey.shade200,
        ),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primaryColor,
          ),
        ),
      );
    }
    // =================================

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
        width: 200.w,
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.containerLightBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 100.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.r),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: ads.image ?? '',
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade200,
                    child: Icon(Icons.error, size: 30.sp),
                  ),
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
                          text: ads.title ?? 'No title',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          fontSize: 14.sp,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.ratingStarColor,
                            size: 12.sp,
                          ),
                          2.wt,
                          primaryText(
                            text:
                                ads.jobPoster?.ratingAverage?.toString() ??
                                '0.0',
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                  4.ht,
                  primaryText(
                    text: ads.jobPoster?.name.toUpperCase() ?? 'Unknown',
                    fontSize: 11.sp,
                  ),
                  4.ht,
                  secondaryText(
                    text: capitalizeFirst(ads.category),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    fontSize: 11.sp,
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
                          secondaryText(text: ' / hour', fontSize: 11.sp),
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
