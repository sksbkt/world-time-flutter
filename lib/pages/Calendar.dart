import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
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
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        cellBorderColor: Colors.transparent,
        onTap: (calendarTapDetails) {
          print(calendarTapDetails.appointments);
        },
      ),
    );
  }
}
