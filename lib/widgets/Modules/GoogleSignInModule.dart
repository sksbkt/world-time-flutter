import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/GoogleSignInProvider.dart';

class GoogleSignInModuleWidget extends StatelessWidget {
  const GoogleSignInModuleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
              child: TextButton.icon(
                  onPressed: () {
                    final provider = Provider.of<GoogleSingInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                  icon: Icon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Google Sing in',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 19),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size.fromHeight(60))),
            ),
          )
        ],
      ),
    );
  }
}
