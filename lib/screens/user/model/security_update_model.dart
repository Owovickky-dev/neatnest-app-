class SecurityUpdateModel {
  String? newPassword;
  String? confirmPassword;
  String? phoneNumber;
  String? newMail;
  String? oldPassword;
  String? password;
  String? oldPhoneNumber;
  String? oldEmail;
  String? newPhoneNumber;

  SecurityUpdateModel({
    this.phoneNumber,
    this.password,
    this.newMail,
    this.confirmPassword,
    this.newPassword,
    this.oldPassword,
    this.oldEmail,
    this.oldPhoneNumber,
    this.newPhoneNumber,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (newPassword != null && newPassword!.isNotEmpty) {
      data["newPassword"] = newPassword;
    }
    if (confirmPassword != null && confirmPassword!.isNotEmpty) {
      data["confirmPassword"] = confirmPassword;
    }
    if (newMail != null && newMail!.isNotEmpty) {
      data["newMail"] = newMail;
    }
    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      data["phoneNumber"] = phoneNumber;
    }
    if (oldPassword != null && oldPassword!.isNotEmpty) {
      data["oldPassword"] = oldPassword;
    }
    if (password != null && password!.isNotEmpty) {
      data["password"] = password;
    }
    if (oldPhoneNumber != null && oldPhoneNumber!.isNotEmpty) {
      data["oldPhoneNumber"] = oldPhoneNumber;
    }
    if (oldEmail != null && oldEmail!.isNotEmpty) {
      data["oldEmail"] = oldEmail;
    }
    if (newPhoneNumber != null && newPhoneNumber!.isNotEmpty) {
      data["newPhoneNumber"] = newPhoneNumber;
    }
    return data;
  }
}
