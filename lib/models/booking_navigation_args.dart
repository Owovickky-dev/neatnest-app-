class BookingNavigationArgs {
  final int index;
  final bool isMe;
  final bool isPopularAds;

  BookingNavigationArgs({
    required this.isMe,
    required this.index,
    this.isPopularAds = false,
  });
}
