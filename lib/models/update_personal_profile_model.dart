class UpdatePersonalProfileModel {
  final String? username;
  final String? fullName;
  final String password;

  UpdatePersonalProfileModel({
    this.fullName,
    this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final userInfoData = <String, dynamic>{};
    if (username != null && username!.isNotEmpty) {
      userInfoData["username"] = username;
    }
    if (fullName != null && fullName!.isNotEmpty) {
      userInfoData["name"] = fullName;
    }
    userInfoData["password"] = password;

    return userInfoData;
  }
}
