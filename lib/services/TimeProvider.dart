import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TimeUpdater with ChangeNotifier {
  DateTime time = DateTime.now().toUtc();

  bool hoursFormat24 = false;
  bool showSeconds = true;

  String dateFormat = 'jm';

  DateFormat format = DateFormat.jm();
  Timer _timer = Timer.periodic(Duration.zero, (timer) {});
  void updateTime(int offHours, int offMins) {
    if (_timer.isActive) _timer.cancel();
    time =
        DateTime.now().toUtc().add(Duration(hours: offHours, minutes: offMins));
    // print(offHours.toString() + ' ' + offMins.toString());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // print(_timer.tick);
      time = DateTime.now()
          .toUtc()
          .add(Duration(hours: offHours, minutes: offMins));
      // print(time);
      notifyListeners();
    });
  }

  void changeDateformat(String input) {
    switch (input) {
      case 'jm':
        format = DateFormat.jm();
        break;
      case 'jms':
        format = DateFormat.jms();
        break;
      case 'Hm':
        format = DateFormat.jms();
        break;
    }
    dateFormat = input;
    notifyListeners();
    // print(format.format(time).toString());
    // print(dateFormat);
  }

  String getTime() {
    // print(format.format(time));
    return DateFormat(getHour() + 'm' + getSeconds()).format(time);
  }

  void toggleHoursFormat24(bool value) {
    hoursFormat24 = value;
    notifyListeners();
  }

  String getHour() {
    return hoursFormat24 ? 'H' : 'j';
  }

  String getSeconds() {
    return showSeconds ? 's' : '';
  }
}
