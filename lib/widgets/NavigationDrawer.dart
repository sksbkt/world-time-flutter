import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:world_time/widgets/LoggedInDrawer.dart';

class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({Key? key, Color? this.DrawerBg}) : super(key: key);

  final Color? DrawerBg;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color: DrawerBg,
            child: ListView(
              children: [
                LoggedInDrawerWidget(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                BuildMenuItem(
                    text: 'Schedule',
                    icon: FontAwesomeIcons.calendarAlt,
                    onClick: () => selectedItem(context, 0)),
                BuildMenuItem(
                    text: 'Time deck',
                    icon: FontAwesomeIcons.clock,
                    onClick: () => selectedItem(context, 1))
              ],
            )));
  }
}

Widget BuildMenuItem(
    {required String text, required IconData icon, VoidCallback? onClick}) {
  const color = Colors.white;
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      text,
      style: TextStyle(color: color),
    ),
    onTap: onClick,
  );
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context)
      .pop(); //closes the navigation menu before switchiing pages
  switch (index) {
    case 0:
      Navigator.of(context).pushNamed('/schedule');
      break;
    case 1:
      Navigator.of(context).pushNamed('/time_deck');
      break;
  }
}
