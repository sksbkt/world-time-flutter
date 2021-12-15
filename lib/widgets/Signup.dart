import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 3,
          ),
          FlutterLogo(
            size: 140,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Welcome aboard',
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.grey[200],
                  fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Signup using Google account',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500]),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          TextButton.icon(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size.fromHeight(60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3))),
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              label: Text(
                'Signup',
                style: TextStyle(color: Colors.grey[800], fontSize: 18),
              )),
          SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                'Already have and account!',
                style: TextStyle(color: Colors.grey[300]),
              )),
          Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
