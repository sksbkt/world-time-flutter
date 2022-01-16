import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/TimeProvider.dart';
import 'package:world_time/utilities/Themes.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final proTime = Provider.of<TimeUpdater>(context, listen: false);
    // final String selectedDateFormat = proTime.dateFormat;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
          child: Consumer2<ThemeProvider, TimeUpdater>(
        builder: (context, ThemeProvider, TimeUpdater, child) => ListView(
          children: [
            ListTile(
              title: Text('Dark mode'),
              trailing: Switch.adaptive(
                  value: themeProvider.isDarkmode,
                  onChanged: (value) {
                    themeProvider.toggleThemeMode(value);
                  }),
            ),
            ListTile(
              title: Text('Time format'),
              trailing: DropdownButton<String>(
                value: proTime.dateFormat,
                items: <String>['jm', 'jms'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    onTap: () {
                      proTime.changeDateformat(value);
                    },
                  );
                }).toList(),
                onChanged: (_) {
                  // setState(() {});
                },
              ),
            ),
            ListTile(
              title: Text('24'),
              trailing: Switch.adaptive(
                  value: proTime.hoursFormat24,
                  onChanged: (value) {
                    proTime.toggleHoursFormat24(value);
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
