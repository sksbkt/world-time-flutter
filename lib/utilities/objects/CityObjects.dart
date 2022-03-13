class CityObject {
  final String location;
  String flag;
  String url;
  CityObject({required this.location, required this.flag, required this.url});

  static List<CityObject> locations = [
    CityObject(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    CityObject(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    CityObject(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    CityObject(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    CityObject(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    CityObject(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    CityObject(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    CityObject(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];
  static CityObject firstCity(String location) {
    return CityObject.locations
        .where((element) => element.location == location)
        .first;
  }

  static Future<List<CityObject>> Suggestion(String query) async {
    return locations
        .where((element) =>
            element.location.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
