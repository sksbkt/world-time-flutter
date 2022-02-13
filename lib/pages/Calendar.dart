import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:world_time/pages/event_editing_page.dart';
import 'package:world_time/services/EventProvider.dart';
import 'package:world_time/utilities/Event.dart';
import 'package:world_time/utilities/EventDataSource.dart';
import 'package:world_time/widgets/Modules/DB/Events_DataBase.dart';
import 'package:world_time/pages/Tasks_widget.dart';
import 'package:world_time/widgets/NavigationDrawer.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key, Color? this.bgColor}) : super(key: key);
  final Color? bgColor;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  EventsDatabase dbHelper = EventsDatabase.instance;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: FutureBuilder(
        future: dbHelper.readAllEvent(),
        builder: (context, snapShot) {
          // List<Appointment> collection = <Appointment>[];
          //
          // if (snapShot.hasData) {
          //   var eventsData = (snapShot.data as List<Event>).toList();
          //   eventsData.forEach((event) {
          //     collection.add(Appointment(
          //         subject: event.title,
          //         startTime: event.from,
          //         endTime: event.to));
          //   });
          // }
          return SfCalendarTheme(
            data: SfCalendarThemeData(
              backgroundColor: Colors.grey.shade300,
              viewHeaderDayTextStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              viewHeaderBackgroundColor: Colors.grey.shade800,
              todayTextStyle: TextStyle(color: Colors.white),
              todayHighlightColor: Colors.purple.shade400,
              activeDatesTextStyle: TextStyle(color: Colors.grey.shade900),
              leadingDatesTextStyle: TextStyle(color: Colors.grey),
              trailingDatesTextStyle: TextStyle(color: Colors.grey),
              headerTextStyle: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: EventDataSource(snapShot),
              cellBorderColor: Colors.transparent,
              onTap: (calendarTapDetails) {
                // print(calendarTapDetails.appointments);
              },
              onLongPress: (details) {
                // final provider =
                //     Provider.of<EventProvider>(context, listen: false);
                // provider.setDate(details.date!);
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return TasksWidget(
                        dateTime: details.date,
                      );
                    });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        hoverElevation: 0,
        backgroundColor: Colors.blue.shade500,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EventEditingPage())),
      ),
    );
  }
}
