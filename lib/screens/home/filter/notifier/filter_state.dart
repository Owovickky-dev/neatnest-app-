import 'package:neat_nest/models/filter_search_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_state.g.dart';

@Riverpod(keepAlive: true)
class FilterState extends _$FilterState {
  @override
  FilterSearchModel? build() {
    return null;
  }

  void setCountry(String? country) {
    state = (state ?? FilterSearchModel()).copyWith(country: country);
  }

  void setUserState(String? userState) {
    state = (state ?? FilterSearchModel()).copyWith(userState: userState);
  }

  void setCategory(String? category) {
    state = (state ?? FilterSearchModel()).copyWith(category: category);
  }

  void setMaxPrice(int? maxPrice) {
    state = (state ?? FilterSearchModel()).copyWith(maxPrice: maxPrice);
  }

  void setMinPrice(int? minPrice) {
    state = (state ?? FilterSearchModel()).copyWith(minPrice: minPrice);
  }

  void setMinRating(double? minRating) {
    state = (state ?? FilterSearchModel()).copyWith(minRating: minRating);
  }

  void setMaxRating(double? maxRating) {
    state = (state ?? FilterSearchModel()).copyWith(maxRating: maxRating);
  }

  void reset() {
    state = null;
  }
}
