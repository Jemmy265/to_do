import 'package:intl/intl.dart';

class MyDateUtils {
  static String FormatTaskDate(DateTime dateTime) {
    var formatter = DateFormat("yyyy MM dd");
    return formatter.format(dateTime);
  }
}