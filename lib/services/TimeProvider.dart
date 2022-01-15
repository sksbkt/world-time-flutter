import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TimeUpdater with ChangeNotifier {
  DateTime time = DateTime.now().toUtc();
  String dateFormat = 'jm';
  DateFormat format = DateFormat.jm();
  Timer _timer = Timer.periodic(Duration.zero, (timer) {});
  void updateTime(int offHours, int offMins) {
    if (_timer.isActive) _timer.cancel();
    time =
        DateTime.now().toUtc().add(Duration(hours: offHours, minutes: offMins));
    print(offHours.toString() + ' ' + offMins.toString());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print(_timer.tick);
      time = DateTime.now()
          .toUtc()
          .add(Duration(hours: offHours, minutes: offMins));
      print(time);
      notifyListeners();
    });
  }

  void changeDateformat(String input) {
    switch (input) {
      case 'jm':
        dateFormat = input;
        format = DateFormat.jm();
        break;
      case 'jms':
        dateFormat = input;
        format = DateFormat.jms();
        break;
    }
    // print(format.format(time).toString());
    // print(dateFormat);
  }

  String getTime() {
    print(format.format(time));
    return format.format(time);
  }
}
