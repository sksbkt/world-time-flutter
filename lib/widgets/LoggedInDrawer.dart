import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoggedInDrawerWidget extends StatelessWidget {
  LoggedInDrawerWidget({Color? bgColor});
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.email!,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 17),
                    )
                  ],
                )
              ],
            )
          ],
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
    ));
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
