import 'dart:async';

import 'package:flutter/foundation.dart';

class TimeUpdater with ChangeNotifier {
  DateTime time = DateTime.now().toUtc();
  late Timer _timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  void updateTime(int offHours, int offMins) async {
    var duration = Duration.zero;
    if (_timer.isActive) _timer.cancel();
    _timer = Timer.periodic(duration, (timer) {
      time = DateTime.now()
          .toUtc()
          .add(Duration(hours: offHours, minutes: offMins));
      notifyListeners();
      duration = Duration(seconds: 1);
    });
  }
}
