import 'package:intl/intl.dart';

class BrasilDateFormat {
  final DateFormat _brasilDateFormat = DateFormat("dd/MM/yyyy");
  final DateFormat _timeFormat = DateFormat("HH:mm");

  String formatDate(DateTime date) {
    return _brasilDateFormat.format(date);
  }

  String formatTime(DateTime date) {
    return _timeFormat.format(date);
  }

  DateTime dateFromBrasilDateTimeFormat(String date) {
    return _brasilDateFormat.parse(date);
  }
}
