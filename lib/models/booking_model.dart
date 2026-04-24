class BookingModel {
  final String serviceName;
  final String serviceProvider;
  final String date;
  final double price;
  final String image;

  BookingModel({
    required this.date,
    required this.image,
    required this.price,
    required this.serviceName,
    required this.serviceProvider,
  });

  Map<String, dynamic> toJson() {
    return {
      'serviceName': serviceName,
      'serviceProvider': serviceProvider,
      'date': date,
      'price': price,
      'imagePath': image,
    };
  }

  // this convert map to object for retrieving and make it useful
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      date: json['date'],
      image: json['imagePath'],
      price: json['price'],
      serviceName: json['serviceName'],
      serviceProvider: json['serviceProvider'],
    );
  }
}
