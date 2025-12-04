import 'package:neat_nest/models/ads_model.dart';

class UserAdsModel {
  final List<AdsModel> totalAds;
  final List<AdsModel> activeAds;

  UserAdsModel({required this.activeAds, required this.totalAds});
}
