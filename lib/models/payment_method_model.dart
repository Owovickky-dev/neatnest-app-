import 'dart:core';

import 'package:flutter/cupertino.dart';

class PaymentMethodModel {
  final String title;
  final dynamic icon;

  PaymentMethodModel({required this.title, required this.icon});

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "icon": {
        "codePoint": icon.codePoint,
        "fontFamily": icon.fontFamily,
        "fontPackage": icon.fontPackage,
      },
    };
  }

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      title: json['title'],
      //IconData (what you’re using for icons) cannot be directly serialized to JSON because it’s just a Dart object that represents an icon, not a string/number.
      icon: IconData(
        json["icon"]["codePoint"],
        fontFamily: json["icon"]["fontFamily"],
        fontPackage: json["icon"]["fontPackage"],
      ),
    );
  }
}
