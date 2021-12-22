import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/widgets/LoggedIn.dart';
import 'package:world_time/widgets/Signup.dart';

class account extends StatelessWidget {
  account({Key? key}) : super(key: key);
  final color = Colors.grey[900];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: SpinKitChasingDots(color: Colors.white, size: 50));
            } else if (snapshot.hasData) {
              return LoggedInWidget();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong!'),
              );
            } else {
              return SignupWidget();
            }
          }),
    );
  }
}
