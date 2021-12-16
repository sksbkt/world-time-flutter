import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoggedInWidget extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Logged in'),
          centerTitle: true,
          actions: [
            TextButton.icon(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.signOutAlt),
                label: Text('Sing out'))
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          color: Colors.blueGrey.shade900,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'profile',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white60),
              ),
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(user.photoURL!),
              )
            ],
          ),
        ));
  }
}
