import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoggedInDrawerWidget extends StatelessWidget {
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
                  // child: Text(
                  //   user.displayName!.substring(0, 2),
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold, color: Colors.grey[300]),
                  // ),
                  radius: 30,
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
        BuildMenuItem(text: 'schedule', icon: FontAwesomeIcons.calendarAlt)
      ],
    ));
  }
}

Widget BuildMenuItem({required String text, required IconData icon}) {
  final color = Colors.white;
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      text,
      style: TextStyle(color: color),
    ),
    onTap: () {},
  );
}
