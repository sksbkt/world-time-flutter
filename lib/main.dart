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
import 'package:world_time/services/TimeProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider<GoogleSingInProvider>(
            create: (context) => GoogleSingInProvider()),
        // Provider<TimeUpdater>(create: (context) => TimeUpdater()),
        ChangeNotifierProvider(create: (context) => TimeUpdater())
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => Home(),
          '/location': (context) => ChooseLocation(),
          '/account': (context) => account(),
          '/schedule': (context) => Schedule(),
          '/time_deck': (context) => TimeDeck(),
        },
      ),
    ),
  );
}
