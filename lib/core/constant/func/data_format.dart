import 'package:intl/intl.dart';

String dateTimeFormat(String date, String format) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat(format).format(dateTime);
  return formattedDate;
}
