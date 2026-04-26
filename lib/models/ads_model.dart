import 'dart:io';

import 'package:dio/dio.dart';

import 'job_poster_model.dart';

class AdsModel {
  final String? id;
  final String? title;
  final String? about;
  final num? basePrice;
  final String? imageFrmServer;
  final File? image;
  final String? country;
  final String? state;
  final JobPosterModel? jobPoster;
  final String? category;
  final bool? isActive;
  final String? workerId;
  final DateTime? createdAt;
  final List<WorkerAvailableInfoModel>? availableSchedule;

  AdsModel({
    this.id,
    this.title,
    this.about,
    this.basePrice,
    this.category,
    this.imageFrmServer,
    this.isActive,
    this.jobPoster,
    this.workerId,
    this.createdAt,
    this.country,
    this.state,
    this.availableSchedule,
    this.image,
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

    if (availableSchedule != null && availableSchedule!.isNotEmpty) {
      data["availableSchedule"] = availableSchedule;
    }

    return data;
  }

  Future<FormData> toFormData() async {
    final map = toJson();

    if (image != null) {
      map["image"] = await MultipartFile.fromFile(
        image!.path,
        filename: image!.path.split("/").last,
      );
    }
    return FormData.fromMap(map);
  }

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json['_id'],
      title: json["title"] ?? "",
      about: json["about"] ?? "",
      basePrice: json["basePrice"] ?? 0,
      category: json["category"] ?? "",
      imageFrmServer: json["image"] ?? "",
      isActive: json["isActive"] ?? false,
      country: json["country"] ?? "",
      state: json["state"] ?? "",
      availableSchedule: json["workerAvailableInfo"] != null
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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (workerAvailableDates.isNotEmpty) {
      data["workerAvailableDates"] = workerAvailableDates;
    }

    if (workerAvailableTimes.isNotEmpty) {
      data["workerAvailableTimes"] = workerAvailableTimes;
    }

    return data;
  }

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

  WorkerAvailableTime({required this.time, this.isBooked = false});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (time.isNotEmpty) {
      data["time"] = time;
    }
    return data;
  }

  factory WorkerAvailableTime.fromJson(Map<String, dynamic> json) {
    return WorkerAvailableTime(time: json["time"], isBooked: json["isBooked"]);
  }
}
