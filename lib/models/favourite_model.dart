import 'package:neat_nest/models/ads_model.dart';

class FavouriteModel {
  final String? adsId;
  final String? favouriteId;
  final AdsModel? adsModel;

  FavouriteModel({this.adsModel, this.adsId, this.favouriteId});

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      favouriteId: json["_id"],
      adsId: json["adsId"]["_id"] ?? "",
      adsModel: AdsModel.fromJson(json["adsId"] ?? {}),
    );
  }
}
