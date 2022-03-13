import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:world_time/services/world_time.dart';
import 'package:world_time/utilities/objects/CityObjects.dart';
import 'package:world_time/widgets/LoggedInDrawer.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key, this.DrawerBg}) : super(key: key);

  final Color? DrawerBg;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Theme(
        data: ThemeData(
            colorSchemeSeed: Colors.red,
            iconTheme: IconThemeData(color: Colors.yellow)),
        child: Container(
            child: ListView(
          children: [
            LoggedInDrawerWidget(),
            buildSearchField(context),
            // TextFormField(),
            const SizedBox(
              height: 10,
            ),
            buildMenuItem(
              text: 'Schedule',
              icon: FontAwesomeIcons.calendarAlt,
              onClick: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: 'Time deck',
              icon: FontAwesomeIcons.clock,
              onClick: () => selectedItem(context, 1),
            ),
            buildMenuItem(
              text: 'Settings',
              icon: FontAwesomeIcons.cog,
              onClick: () => selectedItem(context, 2),
            ),
          ],
        )),
      ),
    );
  }
}

Widget buildSearchField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    child: TypeAheadField<CityObject>(
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      debounceDuration: Duration(microseconds: 500),
      // hideSuggestionsOnKeyboardHide: false,///could be problematic since we are using this feature in the navbar
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            hintText: 'Search',
            filled: true,
            prefixIcon: const Icon(
              Icons.search,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.white))),
      ),
      suggestionsCallback: CityObject.Suggestion,
      itemBuilder: (context, CityObject? suggestion) {
        final location = suggestion!;
        return ListTile(
          leading: CircleAvatar(
            radius: 17,
            backgroundImage: AssetImage('assets/${suggestion.flag}'),
          ),
          onTap: () async {
            print('ssss');
            WorldTime().location = location.location;
            await WorldTime().getTime();
            //TODO: there is an issue with showing the result on home page
            print(location.location);
            Navigator.pushReplacementNamed(context, '/home', arguments: {
              'timeObject': suggestion
              // 'location': location.location,
              // 'flag': location.flag,
              // 'time': location.time,
              // 'isDayTime': location.isDayTime
            });
          },
          title: Text(location.location),
        );
      },
      onSuggestionSelected: (CityObject? suggestion) {
        final location = suggestion!;

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text('Selected location:${location.location}'),
          ));
      },
      noItemsFoundBuilder: (context) => Container(
        height: 100,
        child: const Center(
          child: Text(
            'no location found:',
          ),
        ),
      ),
    ),
  );
}

Widget buildMenuItem(
    {required String text, required IconData icon, VoidCallback? onClick}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    child: ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        text,
        // style: TextStyle(color: color),
      ),
      onTap: onClick,
    ),
  );
}

void selectedItem(BuildContext context, int index) {
  // print(index);
  Navigator.of(context)
      .pop(); //closes the navigation menu before switchiing pages
  switch (index) {
    case 0:
      Navigator.of(context).pushNamed('/calendar');
      break;
    case 1:
      Navigator.of(context).pushNamed('/time_deck');
      break;
    case 2:
      Navigator.of(context).pushNamed('/Settings');
      break;
  }
}
