import 'package:neat_nest/screens/user/model/user_location_model.dart';
import 'package:neat_nest/screens/user/model/worker_statistics_model.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String? password;
  final String? passwordConfirm;
  final String username;
  final String gender;
  final String role;
  final String phoneNumber;
  final List<UserLocationModel> locations;
  final WorkerStatisticsModel? workerStatistics;
  final bool? isVerfied;
  final double? ratingAverage;
  final double? ratingQuantity;
  final DateTime? joinedAt;

  UserModel({
    this.id,
    required this.name,
    this.password,
    required this.phoneNumber,
    this.passwordConfirm,
    required this.email,
    required this.gender,
    required this.role,
    required this.username,
    this.joinedAt,
    List<UserLocationModel>? locations,
    this.workerStatistics,
    this.isVerfied,
    this.ratingAverage,
    this.ratingQuantity,
  }) : locations = locations ?? [];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "passwordConfirm": passwordConfirm,
      "username": username,
      "gender": gender,
      "role": role,
      "phoneNumber": phoneNumber,
    };
  }

  static List<UserLocationModel> _parseLocations(dynamic locationsData) {
    if (locationsData == null) return [];
    if (locationsData is List) {
      return locationsData
          .whereType<Map<String, dynamic>>()
          .map((locationJson) => UserLocationModel.fromJson(locationJson))
          .toList();
    }
    return [];
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserModel(
        id: json["_id"] ?? json["id"],
        joinedAt: json["joinedAt"] != null
            ? DateTime.parse(json["joinedAt"])
            : null,
        name: json["name"]?.toString() ?? "",
        email: json["email"]?.toString() ?? "",
        gender: json["gender"]?.toString() ?? "",
        role: json["role"]?.toString() ?? "",
        phoneNumber: json["phoneNumber"]?.toString() ?? "",
        ratingAverage: (json["ratingAverage"] as num?)?.toDouble() ?? 0.0,
        ratingQuantity: (json["ratingQuantity"] as num?)?.toDouble() ?? 0.0,
        username: json["username"]?.toString() ?? "",
        isVerfied: json["isVerfied"] ?? false,
        locations: _parseLocations(json["locations"]),
        workerStatistics: json["workerStatistics"] != null
            ? WorkerStatisticsModel.fromJson(json["workerStatistics"])
            : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toFullJson() {
    return {
      "id": id,
      "_id": id,
      "name": name,
      "email": email,
      "username": username,
      "gender": gender,
      "role": role,
      "joinedAt": joinedAt?.toIso8601String(),
      "isVerfied": isVerfied,
      "ratingAverage": ratingAverage,
      "ratingQuantity": ratingQuantity,
      "locations": locations.map((loc) => loc.toJson()).toList(),
      "workerStatistics": workerStatistics?.toJson(),
      "phoneNumber": phoneNumber,
    };
  }
}
