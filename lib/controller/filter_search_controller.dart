import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/screens/home/filter/notifier/filter_state.dart';
import 'package:neat_nest/screens/home/filter/widget/filter_result_screen.dart';
import 'package:neat_nest/widget/loading_screen.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class FilterSearchController {
  FilterSearchController();

  int resetIndex() {
    return -1;
  }

  void submit(WidgetRef ref, BuildContext context) {
    final navigate = Navigator.of(context);
    String? category;
    String? location;
    String? rating;
    double? minPrice;
    double? maxPrice;
    final update = ref.watch(filterStateProvider);
    category = update?.category;
    location = update?.location;
    minPrice = update?.minPrice;
    maxPrice = update?.maxPrice;
    rating = update?.rating;

    if (category == null &&
        minPrice == null &&
        maxPrice == null &&
        location == null &&
        rating == null) {
      showErrorNotification(message: "All filter field can't be empty");
    } else {
      navigate.push(MaterialPageRoute(builder: (_) => LoadingScreen()));

      Future.delayed(Duration(milliseconds: 500), () {
        navigate.pushReplacement(
          MaterialPageRoute(builder: (_) => FilterResultScreen()),
        );
      });

      ref.read(filterStateProvider.notifier).reset();
    }
  }
}
