import 'job_poster_model.dart';

class AdsModel {
  final String? id;
  final String title;
  final String about;
  final int basePrice;
  final String image;
  final JobPosterModel? jobPoster;
  final String category;
  final bool isActive;
  final String? workerId;
  final DateTime? createdAt;

  AdsModel({
    this.id,
    required this.title,
    required this.about,
    required this.basePrice,
    required this.category,
    required this.image,
    required this.isActive,
    this.jobPoster,
    this.workerId,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "about": about,
      "basePrice": basePrice,
      "category": category,
      "image": image,
      "isActive": isActive,
    };
  }

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json['_id'],
      title: json["title"] ?? "",
      about: json["about"] ?? "",
      basePrice: json["basePrice"] ?? 0,
      category: json["category"] ?? "",
      image: json["image"] ?? "",
      isActive: json["isActive"] ?? false,
      jobPoster: JobPosterModel.fromJson(json["jobPoster"] ?? {}),
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : null,
    );
  }
}
