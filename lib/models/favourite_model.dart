import 'package:neat_nest/models/ads_model.dart';

class FavouriteModel {
  final String? adsId;
  final String? favouriteId;
  final AdsModel? adsModel;
  final DateTime? createdAt;

  FavouriteModel({this.adsModel, this.adsId, this.favouriteId, this.createdAt});

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      favouriteId: json["_id"],
      adsModel: AdsModel.fromJson(json["adsId"] ?? {}),
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : null,
    );
  }
}
