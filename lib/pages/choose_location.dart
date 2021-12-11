import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation>
    with WidgetsBindingObserver {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _savePref(index) async {
    await SharedPreferences.getInstance().then((prefs) => {
          prefs.setString('location', locations[index].location),
          print('prefs:'),
          print(prefs.getString('location')),
          prefs.setString('flag', locations[index].flag),
          prefs.setString('url', locations[index].url),
        });
  }

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('choose location'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Card(
              elevation: 0,
              child: ListTile(
                // leading: Container(
                //   height: 40,
                //   width: 40,
                //   decoration: BoxDecoration(
                //       boxShadow: [
                //         BoxShadow(
                //             color: (Colors.grey[400])!,
                //             spreadRadius: 3,
                //             blurRadius: 3)
                //       ],
                //       shape: BoxShape.circle,
                //       // border: Border.all(width: 1, color: (Colors.grey[200])!),
                //       image: DecorationImage(
                //           fit: BoxFit.fill,
                //           image: AssetImage('assets/${locations[index].flag}'))),
                // ),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/${locations[index].flag}'),
                ),
                onTap: () {
                  updateTime(index);
                  _savePref(index);
                },
                title: Text(
                  locations[index].location,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}