import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time/pages/Settings.dart';
import 'package:world_time/pages/account.dart';

import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/schedule.dart';
import 'package:world_time/pages/time_deck.dart';
import 'package:world_time/services/GoogleSignInProvider.dart';
import 'package:world_time/services/TimeProvider.dart';
import 'package:world_time/utilities/Themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(timeApp());
}

class timeApp extends StatelessWidget {
  const timeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        Provider<GoogleSingInProvider>(
            create: (context) => GoogleSingInProvider()),
        // Provider<TimeUpdater>(create: (context) => TimeUpdater()),
        ChangeNotifierProvider(create: (context) => TimeUpdater()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Builder(builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Loading(),
            '/home': (context) => Home(),
            '/location': (context) => ChooseLocation(),
            '/account': (context) => account(),
            '/schedule': (context) => Schedule(),
            '/time_deck': (context) => TimeDeck(),
            '/Settings': (context) => Settings(),
          },
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          themeMode: themeProvider.themeMode,
        );
      }),
    );
  }
}
