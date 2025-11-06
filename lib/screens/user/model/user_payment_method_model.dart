class UserPaymentMethodModel {
  final String? paymentType;
  final String? id;
  final String? accountNumber;
  final String? swiftCode;
  final String? iban;
  final String? routingNumber;
  final String? sortCode;
  final String? bankAddress;
  final String? payPalMail;
  final String? bankName;
  final String? country;
  final String? currency;

  UserPaymentMethodModel({
    this.paymentType,
    this.accountNumber,
    this.bankAddress,
    this.iban,
    this.payPalMail,
    this.routingNumber,
    this.sortCode,
    this.swiftCode,
    this.id,
    this.country,
    this.bankName,
    this.currency,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{'paymentType': paymentType};

    if (accountNumber != null && accountNumber!.isNotEmpty) {
      data['accountNumber'] = accountNumber;
    }
    if (swiftCode != null && swiftCode!.isNotEmpty) {
      data['swiftCode'] = swiftCode;
    }
    if (iban != null && iban!.isNotEmpty) {
      data['iban'] = iban;
    }
    if (routingNumber != null && routingNumber!.isNotEmpty) {
      data['routingNumber'] = routingNumber;
    }
    if (sortCode != null && sortCode!.isNotEmpty) {
      data['sortCode'] = sortCode;
    }
    if (bankAddress != null && bankAddress!.isNotEmpty) {
      data['bankAddress'] = bankAddress;
    }
    if (payPalMail != null && payPalMail!.isNotEmpty) {
      data['payPalMail'] = payPalMail;
    }
    if (id != null && id!.isNotEmpty) {
      data['id'] = id;
    }
    if (currency != null && currency!.isNotEmpty) {
      data['currency'] = currency;
    }
    if (country != null && country!.isNotEmpty) {
      data['country'] = country;
    }
    if (bankName != null && bankName!.isNotEmpty) {
      data['bankName'] = bankName;
    }

    return data;
  }

  factory UserPaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return UserPaymentMethodModel(
      paymentType: json["paymentType"] ?? "",
      accountNumber: json["accountNumber"] ?? "",
      bankAddress: json["bankAddress"] ?? "",
      iban: json["iban"] ?? "",
      payPalMail: json["payPalMail"] ?? "",
      routingNumber: json["routingNumber"] ?? "",
      sortCode: json["sortCode"] ?? "",
      swiftCode: json["swiftCode"] ?? "",
      id: json["_id"] ?? "",
      bankName: json["bankName"] ?? "",
      currency: json["currency"] ?? "",
      country: json["country"] ?? "",
    );
  }

  UserPaymentMethodModel copyWth({
    String? paymentType,
    String? id,
    String? accountNumber,
    String? swiftCode,
    String? iban,
    String? routingNumber,
    String? sortCode,
    String? bankAddress,
    String? payPalMail,
    String? country,
    String? currency,
    String? bankName,
  }) {
    return UserPaymentMethodModel(
      paymentType: paymentType ?? this.paymentType,
      id: id ?? this.id,
      accountNumber: accountNumber ?? this.accountNumber,
      swiftCode: swiftCode ?? this.swiftCode,
      iban: iban ?? this.iban,
      payPalMail: payPalMail ?? this.payPalMail,
      bankAddress: bankAddress ?? this.bankAddress,
      sortCode: sortCode ?? this.sortCode,
      routingNumber: routingNumber ?? this.routingNumber,
      currency: currency ?? this.currency,
      bankName: bankName ?? this.bankName,
      country: country ?? this.country,
    );
  }
}
