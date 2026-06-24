import 'dart:io';

import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserUploadVerificationModel {
  final File? frontImage;
  final File? backImage;
  final String idType;

  UserUploadVerificationModel({
    this.frontImage,
    this.backImage,
    required this.idType,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      "idType": idType,

      if (frontImage != null)
        "frontImage": await MultipartFile.fromFile(
          frontImage!.path,
          filename: frontImage!.path.split("/").last,
        ),

      if (backImage != null)
        "backImage": await MultipartFile.fromFile(
          backImage!.path,
          filename: backImage!.path.split("/").last,
        ),
    });
  }
}

class VerificationModel {
  final VerificationStatus idVerification;
  final VerificationStatus addressVerification;
  final VerificationStatus selfieVerification;
  final VerificationStatus skillsVerification;

  VerificationModel({
    required this.idVerification,
    required this.addressVerification,
    required this.selfieVerification,
    required this.skillsVerification,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      idVerification: _parseStatus(json["idVerification"]),
      addressVerification: _parseStatus(json["addressVerification"]),
      selfieVerification: _parseStatus(json["selfieVerification"]),
      skillsVerification: _parseStatus(json["skillsVerification"]),
    );
  }

  static VerificationStatus _parseStatus(String status) {
    switch (status) {
      case "approved":
        return VerificationStatus.approved;
      case "pending":
        return VerificationStatus.pending;
      case "rejected":
        return VerificationStatus.rejected;
      default:
        return VerificationStatus.notStarted;
    }
  }
}

class VerificationMethod {
  final String title;
  final String subTitle;
  final FaIconData icon;
  final VerificationStatus status;

  VerificationMethod({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.status,
  });
}

enum VerificationStatus { approved, pending, rejected, notStarted }
