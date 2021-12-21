import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/widgets/Modules/GoogleSignInModule.dart';
import 'package:world_time/widgets/Modules/LoggedinModule.dart';

class LoggedInDrawerWidget extends StatelessWidget {
  LoggedInDrawerWidget({Color? bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitChasingDots(
              color: Colors.white,
              size: 30,
            );
          } else if (snapshot.hasData) {
            return loggedInModuleWidget();
          } else if (snapshot.hasError)
            return Text('Something went wrong');
          else
            return GoogleSignInModuleWidget();
        },
      ),
    ));
  }
}
