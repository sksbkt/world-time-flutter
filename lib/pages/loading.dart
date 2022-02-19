import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  String time = 'loading';
  late String location;
  late String flag;
  late String url;
  late Map<String, dynamic> offset;

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // TODO: implement didChangeAppLifecycleState
  //   super.didChangeAppLifecycleState(state);
  //   print('STATE IS' + state.toString());
  //   //TODO:
  // }

  void setupWorldTime() async {
    await _loadPref();
    // WorldTime instance =
    //       WorldTime(location: 'Berlin', flag: 'Germany', url: 'Europe/Berlin');

    WorldTime instance = WorldTime(location: location, flag: flag, url: url);

    await instance.getTime();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
      'offsetHours': instance.offset['offsetHours'],
      'offsetMins': instance.offset['offsetMins'],
    });
    WorldTime.getLocations();
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
    // WidgetsBinding.instance!.addObserver(this);
    // print('init');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Snapshot has error! ${snapshot.error.toString()}');
            return Center(child: Text('Something went wrong'));
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
