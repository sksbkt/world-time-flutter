import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);
    return '$date $time';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    return '$date';
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return '$time';
  }

  static DateTime removeTime(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day);
}

class AlignHelper {
  late double x;
  late double y;
  late BuildContext context;
  AlignHelper(TapUpDetails details) {}

  double toAlignValue(double inputTap, double screenSize) {
    double mid = screenSize / 2;
    double tapPos = inputTap / screenSize;
    print(tapPos.toString());

    return inputTap > mid ? tapPos : tapPos - 1;
  }
}
