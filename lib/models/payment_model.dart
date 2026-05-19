class PaymentModel {
  final String? receiverId;
  final String? bookingId;
  final String? paymentMethod;
  final int? amount;
  final String? currency;
  final String? paymentStatus;

  PaymentModel({
    this.bookingId,
    this.receiverId,
    this.paymentMethod,
    this.amount,
    this.currency,
    this.paymentStatus,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (receiverId != null && receiverId!.isNotEmpty) {
      data["receiverId"] = receiverId;
    }
    if (bookingId != null && bookingId!.isNotEmpty) {
      data["bookingId"] = bookingId;
    }
    if (paymentMethod != null && paymentMethod!.isNotEmpty) {
      data["paymentMethod"] = paymentMethod;
    }
    if (amount != null && amount! > 0) {
      data["amount"] = amount;
    }
    if (currency != null && currency!.isNotEmpty) {
      data["currency"] = currency;
    }
    if (paymentStatus != null && paymentStatus!.isNotEmpty) {
      data["status"] = paymentStatus;
    }
    return data;
  }
}
