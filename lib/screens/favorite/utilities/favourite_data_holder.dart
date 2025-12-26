// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:neat_nest/controller/favourite_controller.dart';
// import 'package:neat_nest/models/ads_model.dart';
// import 'package:neat_nest/screens/booking/booking_screen.dart';
// import 'package:neat_nest/utilities/constant/colors.dart';
// import 'package:neat_nest/utilities/constant/extension.dart';
//
// import '../../../widget/app_text.dart';
//
// class FavouriteDataHolder extends StatefulWidget {
//   const FavouriteDataHolder({super.key, required this.index, this.adsModel});
//
//   final int index;
//   final AdsModel? adsModel;
//
//   @override
//   State<FavouriteDataHolder> createState() => _FavouriteDataHolderState();
// }
//
// class _FavouriteDataHolderState extends State<FavouriteDataHolder> {
//   late FavouriteController _favouriteController;
//   bool isClicked = false;
//
//   String capitalizeFirst(String? text) {
//     if (text == null || text.isEmpty) return '';
//     return text[0].toUpperCase() + text.substring(1);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _favouriteController = FavouriteController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BookingScreen(index: widget.index),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.r),
//           color: AppColors.containerLightBackground,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               height: 130.h,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(2.r),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(2.r),
//                 child: CachedNetworkImage(
//                   fit: BoxFit.cover,
//                   imageUrl: widget.adsModel?.image ?? "No Image",
//                 ),
//               ),
//             ),
//             // Content area
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: primaryText(
//                           text: widget.adsModel!.title!,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           fontSize: 15.sp,
//                         ),
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.star,
//                             color: AppColors.ratingStarColor,
//                             size: 13.sp,
//                           ),
//                           2.wt,
//                           primaryText(
//                             text: widget.adsModel!.jobPoster!.ratingAverage
//                                 .toString(),
//                             fontSize: 13.sp,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   6.ht,
//                   // Username
//                   primaryText(
//                     text: widget.adsModel!.jobPoster!.username.toUpperCase(),
//                     fontSize: 12.sp,
//                   ),
//                   6.ht,
//                   secondaryText(
//                     text: capitalizeFirst(widget.adsModel?.category),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     fontSize: 12.sp,
//                   ),
//                   8.ht,
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           primaryText(
//                             text: '\$${widget.adsModel!.basePrice}',
//                             fontSize: 13.sp,
//                           ),
//                           secondaryText(text: '/hour', fontSize: 12.sp),
//                         ],
//                       ),
//                       GestureDetector(
//                         onTap: () async {
//                           await _favouriteController.addFavourite(context, widget.adsModel!.id!, ref)
//                           setState(() {
//                             isClicked = !isClicked;
//                           });
//                         },
//                         child: Icon(
//                           isClicked ? Icons.favorite : Icons.favorite_border,
//                           color: isClicked ? Colors.red : Colors.black,
//                           size: 18.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/favourite_controller.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/screens/booking/booking_screen.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../widget/app_text.dart';

class FavouriteDataHolder extends ConsumerWidget {
  const FavouriteDataHolder({super.key, required this.index, this.adsModel});

  final int index;
  final AdsModel? adsModel;

  String capitalizeFirst(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourite = FavouriteController();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingScreen(index: index)),
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
            Container(
              width: double.infinity,
              height: 130.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.r),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: adsModel?.image ?? "No Image",
                ),
              ),
            ),
            // Content area
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
                          text: adsModel!.title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          fontSize: 15.sp,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.ratingStarColor,
                            size: 13.sp,
                          ),
                          2.wt,
                          primaryText(
                            text: adsModel!.jobPoster!.ratingAverage.toString(),
                            fontSize: 13.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                  6.ht,
                  // Username
                  primaryText(
                    text: adsModel!.jobPoster!.username.toUpperCase(),
                    fontSize: 12.sp,
                  ),
                  6.ht,
                  secondaryText(
                    text: capitalizeFirst(adsModel?.category),
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
                            text: '\$${adsModel!.basePrice}',
                            fontSize: 13.sp,
                          ),
                          secondaryText(text: '/hour', fontSize: 12.sp),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          favourite.addFavourite(context, adsModel!.id!, ref);
                        },
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
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
