import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/query_ads_state.dart';
import 'package:neat_nest/models/filter_search_model.dart';
import 'package:neat_nest/screens/home/filter/notifier/filter_state.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class FilterSearchController {
  FilterSearchController();

  Future<void> submit(
    BuildContext context,
    WidgetRef ref, {
    String sortBy = '-createdAt',
    page = 1,
    limit = 5,
  }) async {
    final filterData = ref.watch(filterStateProvider);
    final String? country;
    final String? userState;
    final num? minPrice;
    final num? maxPrice;
    final double? minRating;
    final double? maxRating;
    final String? category;

    country = filterData?.country?.toLowerCase();
    userState = filterData?.userState?.toLowerCase();
    minPrice = filterData?.minPrice;
    maxPrice = filterData?.maxPrice;
    minRating = filterData?.minRating;
    maxRating = filterData?.maxRating;
    category = filterData?.category?.toLowerCase();

    print("The category data is $category");

    final queryData = FilterSearchModel(
      country: country,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minRating: minRating,
      maxRating: maxRating,
      userState: userState,
      sort: sortBy,
      page: page,
      limit: limit,
    );
    try {
      await ref.read(queryAdsStateProvider.notifier).queryAds(queryData);
      if (!context.mounted) return;

      // Check if data is loaded and get the length
      final asyncAdsData = ref.read(queryAdsStateProvider);

      if (asyncAdsData.isLoading) {
        return; // Still loading
      }

      // Use when to handle the AsyncValue
      asyncAdsData.when(
        data: (adsList) {
          if (adsList.isNotEmpty) {
            showSuccessNotification(message: "${adsList.length} ads found");
            ref.read(filterStateProvider.notifier).reset();
          }
        },
        loading: () {},
        error: (error, stackTrace) {
          showErrorNotification(message: "Failed to load ads");
        },
      );
    } catch (e) {
      if (!context.mounted) return;
      if (e is DioException) {
        print(e.response?.data);
        showErrorNotification(message: e.error.toString());
      }
    }
  }
}
