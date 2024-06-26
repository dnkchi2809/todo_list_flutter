import 'package:intl/intl.dart';

String getToday() {
  final DateTime today = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String createDate = formatter.format(today);
  return createDate;
}

String getCurrentTime() {
  final DateTime today = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
  final String createDate = formatter.format(today);
  return createDate;
}
