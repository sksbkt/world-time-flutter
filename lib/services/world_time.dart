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
        print(element);
      });
    } catch (e) {}
  }

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      _savePref();
    } catch (e) {
      time = 'Could not get the time';
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
}
