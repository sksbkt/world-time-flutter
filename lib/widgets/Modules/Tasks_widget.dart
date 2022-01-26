import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:world_time/services/EventProvider.dart';
import 'package:world_time/utilities/EventDataSource.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;
    if (selectedEvents.isEmpty)
      return Center(
          child: Text(
        'no events found',
        style: TextStyle(color: Colors.black, fontSize: 24),
      ));

    return SfCalendarTheme(
        data: SfCalendarThemeData(
            timeTextStyle: TextStyle(fontSize: 16, color: Colors.blue)),
        child: SfCalendar(
          view: CalendarView.timelineDay,
          dataSource: EventDataSource(provider.events),
          initialDisplayDate: provider.seletedDate,
          appointmentBuilder: appoinmentBuilder,
          headerHeight: 0,
          selectionDecoration:
              BoxDecoration(color: Colors.white.withOpacity(0.2)),
          onTap: (details) {},
        ));
  }

  Widget appoinmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final event = details.appointments.first;
    return Container(
      decoration: BoxDecoration(
          color: event.backgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)),
      width: details.bounds.width,
      height: details.bounds.height,
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
