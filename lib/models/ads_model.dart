import 'dart:io';

import 'package:dio/dio.dart';

import 'job_poster_model.dart';

class AdsModel {
  final String? id;
  final String? title;
  final String? about;
  final num? basePrice;
  final List<ServerImageModel>? imageFrmServer;
  final List<File>? image;
  final String? country;
  final String? state;
  final JobPosterModel? jobPoster;
  final String? category;
  final bool? isActive;
  final String? workerId;
  final DateTime? createdAt;
  final String? addressId;
  final String? address;
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
    this.address,
    this.addressId,
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
    if (addressId != null && addressId!.isNotEmpty) {
      data["addressId"] = addressId;
    }
    if (id != null && id!.isNotEmpty) {
      data["adsId"] = id;
    }

    if (availableSchedule != null && availableSchedule!.isNotEmpty) {
      data["availableSchedule"] = availableSchedule!
          .map((e) => e.toJson())
          .toList();
    }

    return data;
  }

  Future<FormData> toFormData() async {
    final map = toJson();

    if (image != null && image!.isNotEmpty) {
      map["images"] = await Future.wait(
        image!.map(
          (img) async => MultipartFile.fromFile(
            img.path,
            filename: img.path.split("/").last,
          ),
        ),
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
      category: json["category"] ?? [],
      imageFrmServer: json["images"] != null
          ? (json["images"] as List)
                .map((img) => ServerImageModel.fromJson(img))
                .toList()
          : [],
      isActive: json["isActive"] == true,
      country: json["country"] ?? "",
      state: json["state"] ?? "",
      availableSchedule: json["workerAvailableInfo"] != null
          ? (json["workerAvailableInfo"] as List)
                .map((e) => WorkerAvailableInfoModel.fromJson(e))
                .toList()
          : [],
      jobPoster: json["jobPoster"] != null
          ? JobPosterModel.fromJson(json["jobPoster"])
          : null,
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
    return {
      "availableDate": workerAvailableDates,
      "availableTime": workerAvailableTimes.map((e) => e.time).toList(),
    };
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
    return {"time": time, "isBooked": isBooked};
  }

  factory WorkerAvailableTime.fromJson(Map<String, dynamic> json) {
    return WorkerAvailableTime(
      time: json["time"] ?? "",
      isBooked: json["isBooked"] == true,
    );
  }
}

class RoutingAdsModel {
  final int index;
  final bool isPopular;
  final bool isFavourite;

  RoutingAdsModel({
    required this.index,
    required this.isPopular,
    required this.isFavourite,
  });
}

class ServerImageModel {
  final String imageUrl;
  final String imageId;

  ServerImageModel({required this.imageUrl, required this.imageId});

  factory ServerImageModel.fromJson(Map<String, dynamic> json) {
    return ServerImageModel(
      imageUrl: json["imageUrl"] ?? "",
      imageId: json["_id"] ?? json["id"] ?? "",
    );
  }
}
