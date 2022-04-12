import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:world_time/services/GoogleSignInProvider.dart';
import 'package:world_time/services/TimeProvider.dart';
import 'package:world_time/services/world_time.dart';
import 'package:world_time/utilities/EventDataSource.dart';
import 'package:world_time/utilities/objects/TimeObject.dart';
import 'package:world_time/utilities/objects/TimeOffset.dart';
import 'package:world_time/widgets/BottomNavigationBar.dart';
import 'package:world_time/widgets/NavigationDrawer.dart';

import '../widgets/Modules/DB/Events_DataBase.dart';

class Home extends StatefulWidget {
  final TimeObject? timeobject;
  const Home({Key? key, this.timeobject}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EventsDatabase dbHelper = EventsDatabase.instance;
  // Map data = {};
  late DateTime time;
  // late bool onTick = false;
  late String location;
  // late Timer _timer;
  late int offsethours;
  late int offsetMins;

  // late TimeObject timeObject;
  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero, () {
    //   data = data.isNotEmpty
    //       ? data
    //       : ModalRoute.of(context)?.settings.arguments as Map;
    //   updateTime();
    // });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _timer.cancel();
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // data = data.isNotEmpty
    //     ? data
    //     : ModalRoute.of(context)?.settings.arguments as Map;

    // timeObject = data['timeObject'];

    // offsethours = data['offsetHours'];
    // offsetMins = data['offsetMins'];

    offsethours = TimeOffset(rawOffset: WorldTime().utc_offset).offsetHours;
    offsetMins = TimeOffset(rawOffset: WorldTime().utc_offset).offsetMins;
    // offsetMins = timeObject.offsetMins;

    // offsetMins = int.parse(data['offsetMins']);
    String bgImage =
        WorldTime().isDayTime ? 'assets/day.png' : 'assets/night.png';
    Color? bgColor = WorldTime().isDayTime ? Colors.blue : Colors.indigo[800];
    // if (!onTick) time = DateTime.parse(data['time']);
    // onTick = true;

    final proTime = Provider.of<TimeUpdater>(context, listen: false);
    proTime.updateTime(offsethours, offsetMins);
    return Theme(
      data: ThemeData(colorSchemeSeed: bgColor),
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        ///avoids render overflow issues when keyboard opens up
        // backgroundColor: bgColor,
        drawer: NavigationDrawerWidget(
          DrawerBg: bgColor,
        ),
        appBar: AppBar(
            // backgroundColor: bgColor,
            ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(bgImage), fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: [
                  TextButton.icon(
                      onPressed: () async {
                        dynamic result =
                            await Navigator.pushNamed(context, '/location');
                        setState(() {
                          // onTick = false;
                          // data = {
                          //   'time': result['time'],
                          //   'location': result['location'],
                          //   'flag': result['flag'],
                          //   'offsetHours': result['offsetHours'],
                          //   'offsetMins': result['offsetMins'],
                          //   'isDayTime': result['isDayTime'],
                          // };
                        });
                      },
                      icon: Icon(
                        Icons.edit_location,
                        color: Colors.grey[300],
                      ),
                      label: Text(
                        'Edit location',
                        style: TextStyle(color: Colors.grey[300]),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        WorldTime().location,
                        style: TextStyle(
                            fontSize: 28,
                            letterSpacing: 2,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<TimeUpdater>(
                        builder: (context, TimeUpdater, child) => Column(
                          children: [
                            Text(
                              proTime.getTime(),
                              style:
                                  TextStyle(fontSize: 66, color: Colors.white),
                            ),
                            Text(
                              proTime.getDate(),
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder(
                      future: dbHelper.readAllEvent(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Iterable events = EventDataSource(snapshot)
                              .appointments!
                              .where((element) =>
                                  element.startTime.day == DateTime.now().day);
                          String subject = 'no upcoming events.';
                          String startingHours = '';
                          String startingMins = '';
                          if (events.length > 0) {
                            subject = (events.first as Appointment).subject;
                            startingHours = (events.first as Appointment)
                                .startTime
                                .hour
                                .toString();
                            startingMins = (events.first as Appointment)
                                .startTime
                                .minute
                                .toString();
                          }

                          return SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: ShaderMask(
                              shaderCallback: (bonds) => LinearGradient(
                                      begin: FractionalOffset.centerLeft,
                                      end: FractionalOffset.center,
                                      colors: [
                                        Colors.white.withOpacity(0),
                                        Colors.white
                                      ],
                                      tileMode: TileMode.mirror)
                                  .createShader(bonds),
                              child: Marquee(
                                text: startingHours +
                                    ':' +
                                    startingMins +
                                    ' ' +
                                    subject,
                                //
                                style: TextStyle(color: Colors.white),
                                blankSpace: width,
                                velocity: 90,
                              ),
                            ),
                          );
                        } else {
                          return Text('loading');
                          //TODO: Marquee need more work with multiple appointment enteries and stuff
                        }
                      })
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: ShowBottomNavBar(context: context),
      ),
    );
  }
}
