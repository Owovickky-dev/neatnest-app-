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
  final List<UserLocationModel> locations;
  final WorkerStatisticsModel? workerStatistics;
  final bool? isVerified;
  final double? ratingAverage;
  final double? ratingQuantity;

  UserModel({
    this.id,
    required this.name,
    this.password,
    this.passwordConfirm,
    required this.email,
    required this.gender,
    required this.role,
    required this.username,
    List<UserLocationModel>? locations,
    this.workerStatistics,
    this.isVerified,
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
    return UserModel(
      id: json["_id"],
      name: json["name"] ?? " ",
      email: json["email"] ?? " ",
      gender: json["gender"] ?? " ",
      role: json["role"] ?? " ",
      ratingAverage: (json["ratingAverage"] as num?)?.toDouble() ?? 1,
      ratingQuantity: (json["ratingQuantity"] as num?)?.toDouble() ?? 0,
      username: json["username"] ?? " ",
      isVerified: (json["isVerfied"] is bool) ? json["isVerfied"] : false,
      locations: _parseLocations(json["locations"]),
      workerStatistics: json["workerStatistics"] != null
          ? WorkerStatisticsModel.fromJson(json["workerStatistics"])
          : null,
    );
  }
}
