class BookingModel {
  final String? serviceId;
  final String? customerName;
  final String? customerPhoneNumber;
  final String? customerAddress;
  final String? customerEmail;
  final String? customerNote;
  final String? preferredDate;
  final String? preferredTime;
  final String? bookingId;
  final String? status;

  BookingModel({
    this.serviceId,
    this.customerName,
    this.customerPhoneNumber,
    this.customerAddress,
    this.customerEmail,
    this.customerNote,
    this.preferredDate,
    this.preferredTime,
    this.bookingId,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (serviceId != null && serviceId!.isNotEmpty) {
      data["serviceId"] = serviceId;
    }
    if (customerName != null && customerName!.isNotEmpty) {
      data["customerName"] = customerName;
    }
    if (customerAddress != null && customerAddress!.isNotEmpty) {
      data["customerAddress"] = customerAddress;
    }
    if (customerEmail != null && customerEmail!.isNotEmpty) {
      data["customerEmail"] = customerEmail;
    }
    if (customerNote != null && customerNote!.isNotEmpty) {
      data["customerNote"] = customerNote;
    }
    if (customerPhoneNumber != null && customerPhoneNumber!.isNotEmpty) {
      data["customerPhoneNumber"] = customerPhoneNumber;
    }
    if (preferredDate != null && preferredDate!.isNotEmpty) {
      data["preferredDate"] = preferredDate;
    }
    if (preferredTime != null && preferredTime!.isNotEmpty) {
      data["preferredTime"] = preferredTime;
    }
    if (status != null && status!.isNotEmpty) {
      data["status"] = status;
    }
    return data;
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json["_id"] ?? "",
      customerName: json["customerName"] ?? "",
      customerAddress: json["customerAddress"] ?? "",
      customerEmail: json["customerEmail"] ?? "",
      customerPhoneNumber: json["customerPhoneNumber"] ?? "",
      customerNote: json["customerNote"] ?? "",
      preferredDate: json["bookingDate"] ?? "",
      preferredTime: json["bookingTime"] ?? "",
      status: json["status"] ?? "",
    );
  }
}
