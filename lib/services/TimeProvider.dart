import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TimeUpdater with ChangeNotifier {
  DateTime time = DateTime.now().toUtc();

  bool hoursFormat24 = false;
  bool showSeconds = true;

  Map<String, String> dateFormat = {
    'off': '',
    '7/10/1996': 'yMd',
    'July 10, 1996': 'yMMMMd'
  };
  String dateFormatString = 'off';
  DateFormat dateFormater = DateFormat('yMd');

  DateFormat format = DateFormat.jm();
  Timer _timer = Timer.periodic(Duration.zero, (timer) {});
  void updateTime(int offHours, int offMins) {
    if (_timer.isActive) _timer.cancel();
    time =
        DateTime.now().toUtc().add(Duration(hours: offHours, minutes: offMins));
    // print(offHours.toString() + ' ' + offMins.toString());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      time = DateTime.now()
          .toUtc()
          .add(Duration(hours: offHours, minutes: offMins));

      notifyListeners();
    });
  }

  String getTime() {
    return DateFormat(getHour() + 'm' + getSeconds()).format(time);
  }

  String getDate() {
    return (dateFormater).format(time);
  }

  void switchDateFormatString(String value) {
    dateFormatString = value;
    dateFormater = DateFormat(dateFormat[value]);
  }

  String getDateFormatValue() {
    print('value:' +
        dateFormat.keys.firstWhere((key) => dateFormat[key] == dateFormat,
            orElse: () => 'off'));
    return dateFormat.keys.firstWhere((key) => dateFormat[key] == dateFormat,
        orElse: () => 'off');
  }

  void toggleHoursFormat24(bool value) {
    hoursFormat24 = value;
    notifyListeners();
  }

  void toggleShowSeconds(bool value) {
    showSeconds = value;
    notifyListeners();
  }

  String getHour() {
    return hoursFormat24 ? 'H' : 'j';
  }

  String getSeconds() {
    return showSeconds ? 's' : '';
  }
}
