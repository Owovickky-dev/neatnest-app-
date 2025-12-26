import 'job_poster_model.dart';

class AdsModel {
  final String? id;
  final String? title;
  final String? about;
  final num? basePrice;
  final String? image;
  final String? country;
  final String? state;
  final JobPosterModel? jobPoster;
  final String? category;
  final bool? isActive;
  final String? workerId;
  final DateTime? createdAt;
  final List<String>? availableTime;

  AdsModel({
    this.id,
    this.title,
    this.about,
    this.basePrice,
    this.category,
    this.image,
    this.isActive,
    this.jobPoster,
    this.workerId,
    this.createdAt,
    this.country,
    this.state,
    this.availableTime,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (title != null && title!.isNotEmpty) {
      data["title"] = title;
    }
    if (basePrice != null) {
      data["basePrice"] = basePrice;
    }
    if (about != null && about!.isNotEmpty) {
      data["about"] = about;
    }
    if (image != null && image!.isNotEmpty) {
      data["image"] = image;
    }
    if (isActive != null) {
      data["isActive"] = isActive;
    }
    if (category != null && category!.isNotEmpty) {
      data["category"] = category;
    }
    if (country != null && country!.isNotEmpty) {
      data["country"] = country;
    }
    if (state != null && state!.isNotEmpty) {
      data["state"] = state;
    }
    if (id != null && id!.isNotEmpty) {
      data["adsId"] = id;
    }

    if (availableTime != null && availableTime!.isNotEmpty) {
      data["availableTime"] = availableTime;
    }

    return data;
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
      country: json["country"] ?? "",
      state: json["state"] ?? "",
      availableTime: json["availableTime"] != null
          ? List<String>.from(json["availableTime"])
          : [],
      jobPoster: JobPosterModel.fromJson(json["jobPoster"] ?? {}),
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : null,
    );
  }
}
