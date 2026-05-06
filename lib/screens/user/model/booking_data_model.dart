class BookingDataModel {
  final String leftText;
  final String rightText;
  final String topText;
  final String title;
  final BookingStatus status;

  BookingDataModel({
    required this.leftText,
    required this.rightText,
    required this.topText,
    required this.title,
    required this.status,
  });
}

enum BookingStatus { awaitingConfirmation, cancelled, completed, ongoing }
