import 'package:intl/intl.dart';

class AppTimeConversion {
  static final _timeFormat = DateFormat.jm();
  static final _dateFormat = DateFormat('dd/MM/yy');

  static String formatMessageTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "";

    final date = DateTime.parse(dateString).toLocal();
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(date.year, date.month, date.day);

    final difference = today.difference(messageDay).inDays;

    if (difference == 0) {
      return _timeFormat.format(date);
    }

    if (difference == 1) {
      return "Yesterday, ${_timeFormat.format(date)}";
    }

    return _dateFormat.format(date);
  }
}
