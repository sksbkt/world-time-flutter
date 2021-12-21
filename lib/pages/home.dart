import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/GoogleSignInProvider.dart';
import 'package:world_time/widgets/NavigationDrawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;

    String bgImage = data['isDayTime'] ? 'assets/day.png' : 'assets/night.png';
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[800];
    return Scaffold(
      backgroundColor: bgColor,
      drawer: NavigationDrawerWidget(
        DrawerBg: bgColor,
      ),
      appBar: AppBar(
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(bgImage), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'flag': result['flag'],
                          'isDayTime': result['isDayTime'],
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                      'Edit location',
                      style: TextStyle(color: Colors.grey[300]),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 28, letterSpacing: 2, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['time'],
                      style: TextStyle(fontSize: 66, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
