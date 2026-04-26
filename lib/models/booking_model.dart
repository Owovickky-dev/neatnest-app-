class BookingModel {
  final String serviceId;
  final String customerName;
  final String customerPhoneNumber;
  final String customerAddress;
  final String customerEmail;
  final String customerNote;
  final String preferredDate;
  final String preferredTime;

  BookingModel({
    required this.serviceId,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.customerAddress,
    required this.customerEmail,
    required this.customerNote,
    required this.preferredDate,
    required this.preferredTime,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (serviceId.isNotEmpty) {
      data["serviceId"] = serviceId;
    }
    if (customerName.isNotEmpty) {
      data["customerName"] = customerName;
    }
    if (customerAddress.isNotEmpty) {
      data["customerAddress"] = customerAddress;
    }
    if (customerEmail.isNotEmpty) {
      data["customerEmail"] = customerEmail;
    }
    if (customerNote.isNotEmpty) {
      data["customerNote"] = customerNote;
    }
    if (customerPhoneNumber.isNotEmpty) {
      data["customerPhoneNumber"] = customerPhoneNumber;
    }
    if (preferredDate.isNotEmpty) {
      data["preferredDate"] = preferredDate;
    }
    if (preferredTime.isNotEmpty) {
      data["preferredTime"] = preferredTime;
    }
    return data;
  }
}
