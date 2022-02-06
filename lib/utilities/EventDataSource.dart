import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:world_time/utilities/Event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(Future<List<Event>> appointments) {
    appointments.then((list) {
      this.appointments = list;
    });
  }
  Event getEvent(int index) => appointments![index] as Event;
  @override
  DateTime getStartTime(int index) {
    // TODO: implement getStartTime
    return getEvent(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    // TODO: implement getEndTime
    return getEvent(index).to;
  }

  @override
  String getSubject(int index) {
    // TODO: implement getSubject
    return getEvent(index).title;
  }

  @override
  Color getColor(int index) {
    // TODO: implement getColor
    return getEvent(index).backgroundColor;
  }

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}
