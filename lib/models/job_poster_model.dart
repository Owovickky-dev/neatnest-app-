class JobPosterModel {
  final String id;
  final String name;
  final String username;
  final num? ratingAverage;
  final num? ratingQuantity;
  final String? joinedAt;

  JobPosterModel({
    this.id = "",
    this.name = "",
    this.username = "",
    this.ratingQuantity,
    this.ratingAverage,
    this.joinedAt,
  });

  factory JobPosterModel.fromJson(Map<String, dynamic> json) {
    return JobPosterModel(
      id: json['_id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      username: json['username']?.toString() ?? "",
      ratingAverage: json["ratingAverage"] ?? 0,
      ratingQuantity: json["ratingQuantity"] ?? 0,
      joinedAt: json["createdAt"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'username': username};
  }
}
