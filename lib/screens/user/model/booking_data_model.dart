class BookingDataModel {
  final String topText;
  final String title;
  final BookingStatus status;
  final Function(String bookingId, String bookingStatus) functionLeft;
  final Function(String bookingId, String bookingStatus) functionRight;

  BookingDataModel({
    required this.topText,
    required this.title,
    required this.status,
    required this.functionLeft,
    required this.functionRight,
  });
}

enum BookingStatus { awaitingAction, closed, completed, active, disputed }
