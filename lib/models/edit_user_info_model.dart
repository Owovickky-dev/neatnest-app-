import '../screens/user/model/user_location_model.dart';

class EditUserInfoModel {
  final String? name;
  final String? email;
  final String? password;
  final String? passwordConfirm;
  final String? username;
  final String? phoneNumber;
  final List<UserLocationModel>? locations;

  EditUserInfoModel({
    this.name,
    this.email,
    this.password,
    this.passwordConfirm,
    this.username,
    this.phoneNumber,
    this.locations,
  });

  EditUserInfoModel copyWith({
    String? name,
    String? email,
    String? passwordConfirm,
    String? password,
    String? username,
    String? phoneNumber,
    List<UserLocationModel>? locations,
  }) {
    return EditUserInfoModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      locations: locations ?? this.locations,
    );
  }
}
