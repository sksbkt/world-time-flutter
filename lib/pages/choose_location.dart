import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:world_time/utilities/objects/CityObjects.dart';
import 'package:world_time/utilities/objects/TimeObject.dart';
import 'package:world_time/utilities/objects/TimeOffset.dart';
import 'package:world_time/widgets/Modules/SearchFieldModule.dart';
import 'package:world_time/widgets/Modules/SearchResultModule.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation>
    with WidgetsBindingObserver {
  List<CityObject> locations = CityObject.locations;

  String query = '';
  @override
  void dispose() {
    super.dispose();
  }

  void updateTime(index) async {
    CityObject cityObject = locations[index];
    WorldTime().location = cityObject.location;
    WorldTime().getTime();

    await WorldTime().getTime();
    Navigator.pop(context, {
      // 'location': instance.location,
      // 'flag': instance.flag,
      // 'time': instance.time,
      // 'offsetHours': TimeOffset(rawOffset: instance.offset).offsetHours,
      // 'offsetMins': TimeOffset(rawOffset: instance.offset).offsetMins,
      // 'isDayTime': instance.isDayTime
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
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/${locations[index].flag}'),
                      ),
                      onTap: () {
                        updateTime(index);
                        print(TimeObject(location: locations[index].location)
                            .flag);
                        // _savePref(index);
                      },
                      title: searchResult(query, locations[index].location),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
      Text: query, onChanged: searchLocation, hintText: 'hintText');
  void searchLocation(String query) {
    locations = CityObject.locations;
    final searchLoc = locations.where((loc) {
      return loc.location.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      this.locations = searchLoc;
      this.query = query;
    });
  }
}
