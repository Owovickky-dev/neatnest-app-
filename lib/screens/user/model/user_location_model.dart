class UserLocationModel {
  final String? city;
  final String? country;
  final String? address;
  final bool? isPrimary;
  final String? state;
  final String? postalCode;

  UserLocationModel({
    this.address,
    this.city,
    this.country,
    this.isPrimary,
    this.state,
    this.postalCode,
  });

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "country": country,
      "address": address,
      "state": state,
      "isPrimary": isPrimary,
      "postalCode": postalCode,
    };
  }

  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    return UserLocationModel(
      city: json["city"],
      country: json["country"],
      address: json["address"],
      isPrimary: json["isPrimary"],
      postalCode: json["postalCode"],
      state: json["state"],
    );
  }
}
