import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:world_time/widgets/Signup.dart';

class account extends StatelessWidget {
  const account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SignupWidget(),
    );
  }
}
