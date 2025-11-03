// class UserLocationModel {
//   final String? city;
//   final String? country;
//   final String? address;
//   final bool? isPrimary;
//
//   UserLocationModel({this.address, this.city, this.country, this.isPrimary});
//
//   Map<String, dynamic> toJson() {
//     return {
//       "city": city,
//       "country": country,
//       "address": address,
//       "isPrimary": isPrimary,
//     };
//   }
//
//   factory UserLocationModel.fromJson(Map<String, dynamic> json) {
//     return UserLocationModel(
//       city: json["city"],
//       country: json["country"],
//       address: json["address"],
//       isPrimary: json["isPrimary"],
//     );
//   }
// }

class UserLocationModel {
  final String? city;
  final String? country;
  final String? address;
  final bool? isPrimary;

  UserLocationModel({this.address, this.city, this.country, this.isPrimary});

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "country": country,
      "address": address,
      "isPrimary": isPrimary,
    };
  }

  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    return UserLocationModel(
      city: json["city"],
      country: json["country"],
      address: json["address"],
      isPrimary: json["isPrimary"],
    );
  }
}
