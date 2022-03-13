import 'package:world_time/services/world_time.dart';
import 'package:world_time/utilities/objects/CityObjects.dart';
import 'package:world_time/utilities/objects/TimeOffset.dart';

class TimeObject {
  String location;
  late String flag;
  // late DateTime time;
  late int offsetHours;
  late int offsetMins;

  TimeObject({required this.location}) {
    CityObject city = CityObject.locations
        .where((element) => element.location == location)
        .first;
    print('offset');
    print(WorldTime().utc_offset);
    TimeOffset timeOffset = new TimeOffset(rawOffset: WorldTime().utc_offset);

    flag = city.flag;
    offsetHours = timeOffset.offsetHours;
    offsetMins = timeOffset.offsetMins;
    // time = WorldTime(location: location).getTime() as DateTime;
  }
}
