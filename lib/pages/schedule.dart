import 'package:flutter/material.dart';
import 'package:world_time/widgets/NavigationDrawer.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key, Color? this.bgColor}) : super(key: key);
  final Color? bgColor;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Schedule'),
      ),
    );
  }
}
