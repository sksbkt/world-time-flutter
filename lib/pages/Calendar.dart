import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:world_time/pages/event_editing_page.dart';
import 'package:world_time/services/EventProvider.dart';
import 'package:world_time/utilities/EventDataSource.dart';
import 'package:world_time/widgets/NavigationDrawer.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key, Color? this.bgColor}) : super(key: key);
  final Color? bgColor;

//   @override
//   State<Calendar> createState() => _CalendarState();
// }
//
// class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: EventDataSource(events),
        cellBorderColor: Colors.transparent,
        onTap: (calendarTapDetails) {
          print(calendarTapDetails.appointments);
        },
      ),
      floatingActionButton: FloatingActionButton(
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
