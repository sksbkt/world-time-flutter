import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loggedInModuleWidget extends StatelessWidget {
  loggedInModuleWidget({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/account');
        },
        child: Ink(
          child: Stack(
            children: [
              ClipRect(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black, BlendMode.colorDodge),
                          fit: BoxFit.cover,
                          image: NetworkImage(user.photoURL!))),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black])),
                      height: 130,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                        child: Row(
                          children: [
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
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
