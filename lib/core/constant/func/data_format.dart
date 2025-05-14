import 'package:intl/intl.dart';

String dateTimeFormat(String? date, String format) {
  if (date == null || date.isEmpty) return '';

  try {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat(format).format(dateTime);
  } catch (e) {
    return '';
  }
}
