import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/models/filter_search_model.dart';
import 'package:neat_nest/screens/home/filter/notifier/filter_state.dart';

class FilterSearchController {
  FilterSearchController();

  void submit(BuildContext context, WidgetRef ref) {
    final filterData = ref.watch(filterStateProvider);
    final String? country;
    final String? userState;
    final int? minPrice;
    final int? maxPrice;
    final double? minRating;
    final double? maxRating;
    final String? category;

    country = filterData?.country;
    userState = filterData?.userState;
    minPrice = filterData?.minPrice;
    maxPrice = filterData?.maxPrice;
    minRating = filterData?.minRating;
    maxRating = filterData?.maxRating;
    category = filterData?.category;

    final queryData = FilterSearchModel(
      country: country,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minRating: minRating,
      maxRating: maxRating,
      userState: userState,
    );
  }
}
