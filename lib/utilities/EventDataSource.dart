import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:world_time/utilities/Event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(AsyncSnapshot snapshot) {
    List<Appointment> collection = <Appointment>[];

    if (snapshot.hasData) {
      var eventsData = (snapshot.data as List<Event>).toList();
      eventsData.forEach((event) {
        collection.add(Appointment(
            id: event.id,
            subject: event.title,
            notes: event.description,
            startTime: event.from,
            endTime: event.to,
            color: event.backgroundColor));
      });
    }
    this.appointments = collection;
    //TODO: we need to implement a way so we can read data to our datasource
  }
  Event getEvent(int index) {
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
