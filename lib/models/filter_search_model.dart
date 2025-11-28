class FilterSearchModel {
  final int? maxPrice;
  final int? minPrice;
  final double? minRating;
  final double? maxRating;
  final String? country;
  final String? userState;
  final String? category;

  FilterSearchModel({
    this.maxPrice,
    this.minPrice,
    this.minRating,
    this.maxRating,
    this.country,
    this.userState,
    this.category,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (category != null && category!.isNotEmpty) {
      data["category"] = category;
    }
    if (country != null && country!.isNotEmpty) {
      data["country"] = country;
    }
    if (userState != null && userState!.isNotEmpty) {
      data["state"] = userState;
    }
    if (maxPrice != null) {
      data["maxPrice"] = maxPrice;
    }
    if (minPrice != null) {
      data["minPrice"] = minPrice;
    }
    if (maxRating != null) {
      data["maxRating"] = maxRating;
    }
    if (minRating != null) {
      data["minRating"] = minRating;
    }
    return data;
  }

  FilterSearchModel copyWith({
    int? maxPrice,
    int? minPrice,
    double? minRating,
    double? maxRating,
    String? country,
    String? userState,
    String? category,
  }) {
    return FilterSearchModel(
      maxPrice: maxPrice ?? this.maxPrice,
      minPrice: minPrice ?? this.minPrice,
      minRating: minRating ?? this.minRating,
      maxRating: maxRating ?? this.maxRating,
      country: country ?? this.country,
      userState: userState ?? this.userState,
      category: category ?? this.category,
    );
  }
}
