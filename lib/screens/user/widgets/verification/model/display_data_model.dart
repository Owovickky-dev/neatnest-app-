class DisplayDataModel {
  final String title;
  final String frontImage;
  final String? backImage;

  DisplayDataModel({
    required this.title,
    required this.frontImage,
    this.backImage,
  });

  factory DisplayDataModel.fromJson(Map<String, dynamic> json) {
    return DisplayDataModel(
      title: json["idType"],
      frontImage: json["frontImage"]["url"],
      backImage: json["backImage"]["url"],
    );
  }
}
