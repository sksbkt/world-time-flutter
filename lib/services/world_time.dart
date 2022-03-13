import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/utilities/objects/CityObjects.dart';
import 'package:world_time/utilities/objects/TimeObject.dart';
import 'package:world_time/utilities/objects/TimeOffset.dart';

class WorldTime {
  late String location;

  late String time;
  // late String offset;
  late String utc_offset;

  late bool isDayTime;
  late WorldTime worldTime;

  var locations = CityObject.locations;

  static late List locationsNet;

  static WorldTime instance = WorldTime._instance();
  // WorldTime({required this.location});

  WorldTime._instance() {}

  factory WorldTime() {
    return instance;
  }

  // static Future<void> getLocations() async {
  //   try {
  //     final url = Uri.parse('http://worldtimeapi.org/api/timezone/');
  //     final response = await get(url);
  //     locationsNet = json.decode(response.body);
  //     locationsNet.forEach((element) {
  //       // print(element);
  //     });
  //   } catch (e) {}
  // }

  Future<DateTime> getTime() async {
    // DateTime diffrenece;

    // CityObject cityObject = CityObject.firstCity(location);

    try {
      // print('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(Uri.parse(
          'http://worldtimeapi.org/api/timezone/${CityObject.firstCity(location).url}'));

      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      utc_offset = data['utc_offset'];

      DateTime now = DateTime.parse(dateTime);

      TimeOffset timeOffset = new TimeOffset(rawOffset: utc_offset);

      now = now.add(Duration(hours: timeOffset.offsetHours));
      now = now.add(Duration(minutes: timeOffset.offsetMins));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = now.toString();

      // DateFormat.jm().format(now);
      // _savePref();
      return now;
    } catch (e) {
      time = 'Error';
    }
    throw (e) {
      print(e);
    };
  }

  // Future<void> _savePref() async {
  //   // CityObject cityObject = CityObject(location: location, flag: flag, url: url);
  //   await SharedPreferences.getInstance().then((prefs) => {
  //         prefs.setString('location', location),
  //         prefs.setString('flag', flag),
  //         prefs.setString('url', url),
  //         //TODO: TimeOffset.dart implementaation
  //         //     prefs.setString('offsetHours', offset['offsetHours'].toString()),
  //         // prefs.setString('offsetMins', offset['offsetMins'].toString()),
  //         prefs.setString('offsetHours',
  //             TimeOffset(rawOffset: offset).offsetHours.toString()),
  //         prefs.setString('offsetHours',
  //             TimeOffset(rawOffset: offset).offsetMins.toString()),
  //       });
  // }
  //
  // Map<String, dynamic> getOffset(String input) {
  //   int offsetHours = int.parse(input.substring(0, 3));
  //   int offsetMins = int.parse(input.substring(4, 6));
  //   this.offset = {
  //     "offsetHours": offsetHours,
  //     "offsetMins": offsetMins,
  //   };
  //   return this.offset;
  // }
}
