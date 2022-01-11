import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_time/pages/choose_location.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  late int offsetOut;
  late bool isDayTime;
  static List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];
  static late List locationsNet;
  WorldTime({required this.location, required this.flag, required this.url});

  static Future<void> getLocations() async {
    try {
      final url = Uri.parse('http://worldtimeapi.org/api/timezone/');
      final response = await get(url);
      locationsNet = json.decode(response.body);
      locationsNet.forEach((element) {
        // print(element);
      });
    } catch (e) {}
  }

  Future<void> getTime() async {
    DateTime diffrenece;
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String dateTime = data['datetime'];
      String utc_offset = data['utc_offset'];

      DateTime now = DateTime.parse(dateTime);

      now = now.add(getOffset(utc_offset)["offsetHours"]);
      now = now.add(getOffset(utc_offset)["offsetMins"]);

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      _savePref();
    } catch (e) {
      time = 'Error';
    }
  }

  static Future<List<WorldTime>> Suggestion(String query) async {
    return locations
        .where((element) =>
            element.location.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> _savePref() async {
    await SharedPreferences.getInstance().then((prefs) => {
          prefs.setString('location', location),
          prefs.setString('flag', flag),
          prefs.setString('url', url),
        });
  }

  int timeDifference(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute);

    return (to.difference(from).inMinutes);
  }

  Map<String, dynamic> getOffset(String input) {
    Duration offsetHours = Duration(hours: int.parse(input.substring(0, 3)));
    Duration offsetMins = Duration(minutes: int.parse(input.substring(4, 6)));

    return {
      "offsetHours": offsetHours,
      "offsetMins": offsetMins,
    };
  }
}
