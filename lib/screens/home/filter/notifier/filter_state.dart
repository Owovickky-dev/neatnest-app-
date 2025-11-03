import 'package:neat_nest/models/filter_search_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_state.g.dart';

@Riverpod(keepAlive: true)
class FilterState extends _$FilterState {
  @override
  FilterSearchModel? build() {
    return null;
  }

  void setLocation(String? location) {
    state = (state ?? FilterSearchModel()).copyWith(location: location);
  }

  void setCategory(String? category) {
    state = (state ?? FilterSearchModel()).copyWith(category: category);
  }

  void setMaxPrice(double? maxPrice) {
    state = (state ?? FilterSearchModel()).copyWith(maxPrice: maxPrice);
  }

  void setMinPrice(double? minPrice) {
    state = (state ?? FilterSearchModel()).copyWith(minPrice: minPrice);
  }

  void setRating(String? rating) {
    state = (state ?? FilterSearchModel()).copyWith(rating: rating);
  }

  void reset() {
    state = null;
  }
}
