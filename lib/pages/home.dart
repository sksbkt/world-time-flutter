import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/GoogleSignInProvider.dart';
import 'package:world_time/services/TimeProvider.dart';
import 'package:world_time/widgets/NavigationDrawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  late DateTime time;
  // late bool onTick = false;
  late String location;
  // late Timer _timer;
  late int offsethours;
  late int offsetMins;
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
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;
    offsethours = data['offsetHours'];
    offsetMins = data['offsetMins'];
    // offsetMins = int.parse(data['offsetMins']);
    String bgImage = data['isDayTime'] ? 'assets/day.png' : 'assets/night.png';
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[800];
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
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'flag': result['flag'],
                            'offsetHours': result['offsetHours'],
                            'offsetMins': result['offsetMins'],
                            'isDayTime': result['isDayTime'],
                          };
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
                        data['location'],
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
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
