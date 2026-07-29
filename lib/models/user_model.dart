import 'package:neat_nest/models/user_skills_model.dart';
import 'package:neat_nest/screens/user/model/user_location_model.dart';
import 'package:neat_nest/screens/user/model/worker_statistics_model.dart';

class UserModel {
  final String? id;
  final String firstName;
  final String? otherName;
  final String lastName;
  final String email;
  final String? password;
  final String? passwordConfirm;
  final String username;
  final String gender;
  final String role;
  final String? profilePic;
  final String phoneNumber;
  final List<UserLocationModel> locations;
  final WorkerStatisticsModel? workerStatistics;
  final bool? isVerified;
  final double? ratingAverage;
  final double? ratingQuantity;
  final String? joinedAt;
  final String? profilePicPublicId;
  final bool? verificationStarted;
  final List<UserSkillModel>? userSkills;

  UserModel({
    this.id,
    required this.firstName,
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
    this.isVerified,
    this.ratingAverage,
    this.ratingQuantity,
    this.profilePic,
    this.profilePicPublicId,
    this.userSkills,
    this.verificationStarted,
    required this.lastName,
    this.otherName,
  }) : locations = locations ?? [];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (firstName.isNotEmpty) {
      data["firstName"] = firstName;
    }
    if (lastName.isNotEmpty) {
      data["lastName"] = lastName;
    }
    if (otherName != null && otherName!.isNotEmpty) {
      data["otherName"] = otherName;
    }
    if (username.isNotEmpty) {
      data["username"] = username;
    }
    if (email.isNotEmpty) {
      data["email"] = email;
    }
    if (password != null && password!.isNotEmpty) {
      data["password"] = password;
    }
    if (passwordConfirm != null && passwordConfirm!.isNotEmpty) {
      data["passwordConfirm"] = passwordConfirm;
    }
    if (gender.isNotEmpty) {
      data["gender"] = gender;
    }
    if (role.isNotEmpty) {
      data["role"] = role;
    }
    if (userSkills != null && userSkills!.isNotEmpty) {
      data["skills"] = userSkills!.map((skill) => skill.toJson()).toList();
    }
    if (phoneNumber.isNotEmpty) {
      data["phoneNumber"] = phoneNumber;
    }
    return data;
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
      id: json["_id"] ?? json["id"],
      joinedAt: json["joinedAt"]?.toString() ?? "",
      firstName: json["firstName"]?.toString() ?? "",
      lastName: json["lastName"]?.toString() ?? "",
      otherName: json["otherName"]?.toString() ?? "",
      email: json["email"]?.toString() ?? "",
      gender: json["gender"]?.toString() ?? "",
      role: json["role"]?.toString() ?? "",
      phoneNumber: json["phoneNumber"]?.toString() ?? "",
      profilePic: json["profilePic"]?.toString() ?? "",
      profilePicPublicId: json["profilePicPublicId"]?.toString() ?? "",
      ratingAverage: (json["ratingAverage"] as num?)?.toDouble() ?? 0.0,
      ratingQuantity: (json["ratingQuantity"] as num?)?.toDouble() ?? 0.0,
      username: json["username"]?.toString() ?? "",
      isVerified: json["isVerified"] == true,
      verificationStarted: json["verificationStarted"] == true,
      userSkills: json["userSkills"] != null
          ? (json["userSkills"] as List)
                .map((userSkill) => UserSkillModel.fromJson(userSkill))
                .toList()
          : [],
      locations: _parseLocations(json["locations"]),
      workerStatistics: json["workerStatistics"] != null
          ? WorkerStatisticsModel.fromJson(json["workerStatistics"])
          : null,
    );
  }

  Map<String, dynamic> toFullJson() {
    return {
      "id": id,
      "_id": id,
      "firstName": firstName,
      "lastName": lastName,
      "otherName": otherName,
      "email": email,
      "username": username,
      "gender": gender,
      "role": role,
      "joinedAt": joinedAt,
      "isVerified": isVerified,
      "ratingAverage": ratingAverage,
      "ratingQuantity": ratingQuantity,
      "locations": locations.map((loc) => loc.toJson()).toList(),
      "workerStatistics": workerStatistics?.toJson(),
      "phoneNumber": phoneNumber,
      "profilePic": profilePic,
      "profilePicPublicId": profilePicPublicId,
      "userSkills": userSkills,
      "verificationStarted": verificationStarted,
    };
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? otherName,
    String? email,
    String? password,
    String? passwordConfirm,
    String? username,
    String? gender,
    String? role,
    String? profilePic,
    String? phoneNumber,
    List<UserLocationModel>? locations,
    WorkerStatisticsModel? workerStatistics,
    bool? isVerified,
    double? ratingAverage,
    double? ratingQuantity,
    String? joinedAt,
    String? profilePicPublicId,
    bool? verificationStarted,
    List<UserSkillModel>? userSkills,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      otherName: otherName ?? this.otherName,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      profilePic: profilePic ?? this.profilePic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      locations: locations ?? this.locations,
      workerStatistics: workerStatistics ?? this.workerStatistics,
      isVerified: isVerified ?? this.isVerified,
      ratingAverage: ratingAverage ?? this.ratingAverage,
      ratingQuantity: ratingQuantity ?? this.ratingQuantity,
      joinedAt: joinedAt ?? this.joinedAt,
      profilePicPublicId: profilePicPublicId ?? this.profilePicPublicId,
      verificationStarted: verificationStarted ?? this.verificationStarted,
      userSkills: userSkills ?? this.userSkills,
    );
  }
}
