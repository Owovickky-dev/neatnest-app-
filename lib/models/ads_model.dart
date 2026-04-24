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
  final List<WorkerAvailableInfoModel>? availableTime;

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
      data["userAvailableTime"] = availableTime;
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
      availableTime: json["workerAvailableInfo"] != null
          ? (json["workerAvailableInfo"] as List)
                .map((e) => WorkerAvailableInfoModel.fromJson(e))
                .toList()
          : [],
      jobPoster: JobPosterModel.fromJson(json["jobPoster"] ?? {}),
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : null,
    );
  }
}

class WorkerAvailableInfoModel {
  final String workerAvailableDates;
  final List<WorkerAvailableTime> workerAvailableTimes;

  WorkerAvailableInfoModel({
    required this.workerAvailableDates,
    required this.workerAvailableTimes,
  });

  factory WorkerAvailableInfoModel.fromJson(Map<String, dynamic> json) {
    return WorkerAvailableInfoModel(
      workerAvailableDates: json["workerAvailableDates"] ?? "",
      workerAvailableTimes: json["workerAvailableTimes"] != null
          ? (json["workerAvailableTimes"] as List)
                .map((e) => WorkerAvailableTime.fromJson(e))
                .toList()
          : [],
    );
  }
}

class WorkerAvailableTime {
  final String time;
  final bool isBooked;

  WorkerAvailableTime({required this.time, required this.isBooked});

  factory WorkerAvailableTime.fromJson(Map<String, dynamic> json) {
    return WorkerAvailableTime(time: json["time"], isBooked: json["isBooked"]);
  }
}
