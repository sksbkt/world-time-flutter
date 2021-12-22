import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/GoogleSignInProvider.dart';

class GoogleSignInModuleWidget extends StatelessWidget {
  const GoogleSignInModuleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 130,
        color: Colors.grey[800],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Google Sing in',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 19),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        final provider =
            Provider.of<GoogleSingInProvider>(context, listen: false);
        provider.googleLogin();
      },
    );
  }
}
