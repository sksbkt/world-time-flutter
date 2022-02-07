import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:world_time/utilities/Event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(Future<List<Event>> appointments) {
    this.appointments = [
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        id: 1,
        notes: 's',
        color: Colors.white,
      )
    ];
    appointments.then((List<Event> list) {
      this.appointments = list;
    });
    //TODO: we need to implement a way so we can read data to our datasource
  }
  Event getEvent(int index) {
    print('trying to get event: ' + index.toString());
    return appointments![index] as Event;
  }

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
