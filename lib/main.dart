import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time/pages/account.dart';

import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/schedule.dart';
import 'package:world_time/pages/time_deck.dart';
import 'package:world_time/services/GoogleSignInProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => GoogleSingInProvider(),
    child: MaterialApp(
      initialRoute: '/location',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/location': (context) => ChooseLocation(),
        '/account': (context) => account(),
        '/schedule': (context) => Schedule(),
        '/time_deck': (context) => TimeDeck(),
      },
    ),
  ));
}
