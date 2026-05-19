import 'dart:io';

import 'package:dio/dio.dart';

class UserSkillModel {
  final String skill;
  final bool? isVerified;
  final bool? isRejected;
  final String? rejectedReason;
  final String? skillId;
  final String? verificationLevel;
  final List<Documents>? documents;

  UserSkillModel({
    required this.skill,
    this.isVerified,
    this.skillId,
    this.documents,
    this.verificationLevel,
    this.isRejected,
    this.rejectedReason,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (skill.isNotEmpty) {
      data["skill"] = skill;
    }
    if (skillId != null && skillId!.isNotEmpty) {
      data["id"] = skillId;
    }
    if (documents != null && documents!.isNotEmpty) {
      data["documents"] = documents;
    }

    return data;
  }

  factory UserSkillModel.fromJson(Map<String, dynamic> json) {
    return UserSkillModel(
      skill: json["skill"] ?? "",
      isVerified: json["isVerified"] == true,
      verificationLevel: json["verificationLevel"],
      skillId: json["id"] ?? "",
      isRejected: json["isRejected"] == true,
      rejectedReason: json["rejectedReason"] ?? "",
      documents: json["documents"] != null
          ? (json["documents"] as List)
                .map((doc) => Documents.fromJson(doc))
                .toList()
          : [],
    );
  }
}

class Documents {
  final String type;
  final String? docId;
  final String? status;
  final String? url;
  final File? documentPic;

  Documents({
    required this.type,
    this.status,
    this.url,
    this.docId,
    this.documentPic,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (type.isNotEmpty) {
      data["type"] = type;
    }
    if (docId != null && docId!.isNotEmpty) {
      data["docId"] = docId;
    }
    return data;
  }

  Future<FormData> toFormData() async {
    final map = toJson();

    if (documentPic != null) {
      map["image"] = await MultipartFile.fromFile(
        documentPic!.path,
        filename: documentPic!.path.split("/").last,
      );
    }
    return FormData.fromMap(map);
  }

  factory Documents.fromJson(Map<String, dynamic> json) {
    return Documents(
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      url: json["url"] ?? "",
    );
  }
}
