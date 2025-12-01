class FilterSearchModel {
  final num? maxPrice;
  final num? minPrice;
  final double? minRating;
  final double? maxRating;
  final String? country;
  final String? userState;
  final String? category;
  final int? page;
  final int? limit;
  final String? sort;

  FilterSearchModel({
    this.maxPrice,
    this.minPrice,
    this.minRating,
    this.maxRating,
    this.country,
    this.userState,
    this.category,
    this.limit,
    this.page,
    this.sort,
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
      data["basePrice[lte]"] = maxPrice;
    }
    if (minPrice != null) {
      data["basePrice[gte]"] = minPrice;
    }
    if (maxRating != null) {
      data["maxRating[lte]"] = maxRating;
    }
    if (minRating != null) {
      data["minRating[gte]"] = minRating;
    }
    if (page != null) {
      data["page"] = page;
    }
    if (limit != null) {
      data["limit"] = limit;
    }
    if (sort != null && sort!.isNotEmpty) {
      data["sort"] = sort;
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
