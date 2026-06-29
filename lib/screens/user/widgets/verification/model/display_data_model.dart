import 'package:neat_nest/models/verification_model.dart';

class DisplayDataModel {
  final String title;
  final String frontImage;
  final String? backImage;
  final String? rejectedReason;

  DisplayDataModel({
    required this.title,
    required this.frontImage,
    this.backImage,
    this.rejectedReason,
  });

  factory DisplayDataModel.fromJson(Map<String, dynamic> json) {
    final rejectedList = json["rejected"] as List?;
    return DisplayDataModel(
      title: json["idType"] ?? "",
      frontImage: json["frontImage"]["url"] ?? "",
      backImage: json["backImage"]["url"] ?? "",
      rejectedReason:
          rejectedList != null &&
              rejectedList.isNotEmpty &&
              rejectedList.first["reason"] != null
          ? rejectedList.first["reason"]
          : null,
    );
  }
}

class DisplayDatHolderModel {
  final String title;
  final VerificationStatus status;

  DisplayDatHolderModel({required this.title, required this.status});
}
