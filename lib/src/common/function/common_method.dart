import 'package:intl/intl.dart';

class CommonMethod {
  // Formate : 14 May 2021
  static String millisToRealDate(int millis) {
    return DateFormat('dd MMM yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(millis));
  }

  // Get Only Time with AM/PM : 12:00 PM or 12:00 AM
  static String millisToTime(int millis) {
    return DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(millis));
  }
}
