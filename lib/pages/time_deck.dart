import 'package:flutter/material.dart';
import 'package:world_time/widgets/LoggedInDrawer.dart';
import 'package:world_time/widgets/NavigationDrawer.dart';

class TimeDeck extends StatefulWidget {
  const TimeDeck({Key? key}) : super(key: key);

  @override
  _TimeDeckState createState() => _TimeDeckState();
}

class _TimeDeckState extends State<TimeDeck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Time deck'),
      ),
      body: Container(),
    );
  }
}
