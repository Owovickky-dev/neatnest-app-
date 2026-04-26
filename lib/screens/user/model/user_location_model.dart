class UserLocationModel {
  final String? city;
  final String? country;
  final String? address;
  final bool? isPrimary;
  final String? state;
  final String? postalCode;
  final String? addressId;

  UserLocationModel({
    this.address,
    this.city,
    this.country,
    this.isPrimary,
    this.state,
    this.postalCode,
    this.addressId,
  });

  Map<String, dynamic> toJson() {
    final addressData = <String, dynamic>{};

    if (city != null && city!.isNotEmpty) {
      addressData["city"] = city;
    }
    if (postalCode != null && postalCode!.isNotEmpty) {
      addressData["postalCode"] = postalCode;
    }
    if (address != null && address!.isNotEmpty) {
      addressData["address"] = address;
    }
    if (country != null && country!.isNotEmpty) {
      addressData["country"] = country;
    }
    if (state != null && state!.isNotEmpty) {
      addressData["state"] = state;
    }
    if (isPrimary != null) {
      addressData["isPrimary"] = isPrimary;
    }
    if (addressId != null && addressId!.isNotEmpty) {
      addressData["addressId"] = addressId;
    }

    return addressData;
  }

  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    return UserLocationModel(
      city: json["city"],
      country: json["country"],
      address: json["address"],
      isPrimary: json["isPrimary"],
      postalCode: json["postalCode"],
      state: json["state"],
      addressId: json["_id"],
    );
  }
}
