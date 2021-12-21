import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/GoogleSignInProvider.dart';

class LoggedInWidget extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
          actions: [],
        ),
        body: Container(
          alignment: Alignment.center,
          color: Colors.blueGrey.shade900,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Name: ${user.displayName}',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white60),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Name: ${user.email}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white60),
              ),
              TextButton.icon(
                  onPressed: () {
                    final provider = Provider.of<GoogleSingInProvider>(context,
                        listen: false);
                    provider.logOut();
                  },
                  icon: Icon(Icons.logout),
                  label: Text(
                    'logout',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ))
            ],
          ),
        ));
  }
}
