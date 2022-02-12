import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:world_time/pages/event_viewing_page.dart';

import 'package:world_time/services/EventProvider.dart';
import 'package:world_time/utilities/Event.dart';
import 'package:world_time/utilities/EventDataSource.dart';
import 'package:world_time/widgets/Modules/DB/Events_DataBase.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key, DateTime? this.dateTime}) : super(key: key);
  final DateTime? dateTime;
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  final dbhelper = EventsDatabase.instance;
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<EventProvider>(context);
    // final selectedEvents = provider.eventsOfSelectedDate;
    // if (selectedEvents.isEmpty)
    //   return Center(
    //       child: Text(
    //     'no events found',
    //     style: TextStyle(color: Colors.black, fontSize: 24),
    //   ));

    return SfCalendarTheme(
        data: SfCalendarThemeData(
            timeTextStyle: TextStyle(fontSize: 16, color: Colors.blue)),
        child: FutureBuilder(
            future: dbhelper.readAllEvent(),
            builder: (context, snapshot) {
              return SfCalendar(
                view: CalendarView.timelineDay,
                dataSource: EventDataSource(snapshot),
                initialDisplayDate: widget.dateTime,
                appointmentBuilder: appoinmentBuilder,
                headerHeight: 0,
                selectionDecoration:
                    BoxDecoration(color: Colors.white.withOpacity(0.2)),
                onTap: (details) {
                  if (details.appointments == null) return;
                  final first = details.appointments!.first;

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventViewingPage(
                          event: Event.appointmentToEvent(first))));
                },
                onViewChanged: (detail) {},
              );
            }));
  }

  Widget appoinmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;
    return Container(
      decoration: BoxDecoration(
          color: event.color, borderRadius: BorderRadius.circular(12)),
      width: details.bounds.width,
      height: details.bounds.height,
      child: Center(
        child: Text(
          event.subject,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
