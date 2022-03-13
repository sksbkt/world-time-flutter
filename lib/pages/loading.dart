import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:world_time/utilities/Event.dart';
import 'package:world_time/utilities/objects/TimeObject.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  //TODO: firebase will be implemented in navigation bar in a later update
  // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  String time = 'loading';
  late String location;
  late String flag;
  late String url;
  late Map<String, dynamic> offset;

  Future<void> setupWorldTime() async {
    await _loadPref();

    // print(offset);
    // WorldTime instance = WorldTime(location: location, flag: flag, url: url);

    WorldTime().location = location;
    await WorldTime().getTime();

    TimeObject instance = TimeObject(location: location);

    // await WorldTime.instance(location);

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'timeObject': instance
      // 'location': instance.location,
      // 'flag': instance.flag,
      // 'time': instance.time,
      // 'isDayTime': instance.isDayTime,
      // 'offsetHours': instance.offset['offsetHours'],
      // 'offsetMins': instance.offset['offsetMins'],
    });
    // WorldTime.getLocations();
  }

  @override
  void initState() {
    super.initState();
    // setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future: _fbApp,
        future: setupWorldTime(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Snapshot has error! ${snapshot.error.toString()}');
            return Center(child: Text('can not connect to the servers.'));
          } else {
            return Scaffold(
                backgroundColor: Colors.blue[800],
                body: Center(
                  child: SpinKitChasingDots(color: Colors.white, size: 50.0),
                ));
          }
        });
  }

  Future<void> _loadPref() async {
    await SharedPreferences.getInstance().then((pref) => {
          location = pref.getString('location') ?? 'Berlin',
          flag = pref.getString('flag') ?? 'Germany',
          url = pref.getString('url') ?? 'Europe/Berlin',
          offset = {
            'offsetHours': pref.getString('offsetHours') ?? Duration(hours: 0),
            'offsetMins': pref.getString('offsetMins') ?? Duration(minutes: 0)
          }
        });
  }
}
