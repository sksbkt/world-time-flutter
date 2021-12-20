import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/widgets/LoggedInDrawer.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key, Color? this.DrawerBg})
      : super(key: key);

  final Color? DrawerBg;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: DrawerBg,
          child: SafeArea(
            child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitChasingDots(
                    color: Colors.white,
                    size: 30,
                  );
                } else if (snapshot.hasData)
                  return LoggedInDrawerWidget(
                    bgColor: DrawerBg,
                  );
                else if (snapshot.hasError)
                  return Text('Something went wrong');
                else
                  return Text('try again');
              },
            ),
          )),
    );
  }
}
