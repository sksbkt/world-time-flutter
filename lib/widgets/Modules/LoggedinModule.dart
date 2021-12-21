import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loggedInModuleWidget extends StatelessWidget {
  loggedInModuleWidget({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('/account');
      },
      title: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    user.email!,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 17),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
