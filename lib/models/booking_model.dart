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
  final String? role;
  final String? title;
  final String? providerUserName;
  final String? imageUrl;
  final double? price;
  final String? createdAt;
  final String? bookerUserName;
  final String? event;

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
    this.imageUrl,
    this.status,
    this.role,
    this.title,
    this.providerUserName,
    this.price,
    this.createdAt,
    this.bookerUserName,
    this.event,
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
      bookingId: json["id"] ?? json["_id"] ?? "",
      customerName: json["customer"]?["name"] ?? "",
      customerAddress: json["customer"]?["address"] ?? "",
      customerEmail: json["customer"]?["email"] ?? "",
      customerPhoneNumber: json["customer"]?["phoneNumber"] ?? "",
      customerNote: json["customer"]?["note"] ?? "",
      preferredDate: json["bookingDate"] ?? "",
      preferredTime: json["bookingTime"] ?? "",
      serviceId: json["service"]?["id"] ?? "",
      status: json["status"] ?? "",
      role: json["role"] ?? "",
      title: json["service"]?["title"] ?? "",
      providerUserName: json["provider"]?["username"] ?? "",
      imageUrl: json["service"]?["image"] ?? "",
      price: (json["service"]?["basePrice"] as num?)?.toDouble() ?? 0.0,
      createdAt: json["createdAt"] ?? "",
      bookerUserName: json["customer"]?["bookerUserName"] ?? "",
      event: json["event"] ?? "",
    );
  }
}

class GroupedBookings {
  final List<BookingModel> awaitingAction;
  final List<BookingModel> completed;
  final List<BookingModel> active;
  final List<BookingModel> closed;
  final List<BookingModel> disputed;

  GroupedBookings({
    required this.awaitingAction,
    required this.completed,
    required this.active,
    required this.closed,
    required this.disputed,
  });

  factory GroupedBookings.fromJson(Map<String, dynamic> json) {
    return GroupedBookings(
      awaitingAction: (json["awaitingAction"] as List)
          .map((e) => BookingModel.fromJson(e))
          .toList(),
      completed: (json["completed"] as List)
          .map((e) => BookingModel.fromJson(e))
          .toList(),
      active: (json["active"] as List)
          .map((e) => BookingModel.fromJson(e))
          .toList(),
      closed: (json["closed"] as List)
          .map((e) => BookingModel.fromJson(e))
          .toList(),
      disputed: (json["disputed"] as List)
          .map((e) => BookingModel.fromJson(e))
          .toList(),
    );
  }
}
