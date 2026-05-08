class BookingDataModel {
  final String leftText;
  final String rightText;
  final String topText;
  final String title;
  final BookingStatus status;
  final Function(String bookingId) functionLeft;
  final Function(String bookingId) functionRight;

  BookingDataModel({
    required this.leftText,
    required this.rightText,
    required this.topText,
    required this.title,
    required this.status,
    required this.functionLeft,
    required this.functionRight,
  });
}

enum BookingStatus { awaitingAction, cancelled, completed, ongoing }
