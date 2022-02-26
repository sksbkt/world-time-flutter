import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderBuilder extends StatelessWidget {
  const HeaderBuilder({
    Key? key,
    required this.header,
    this.headerStyle,
    this.inline,
    required this.child,
  }) : super(key: key);

  final String header;
  final Widget child;
  final TextStyle? headerStyle;
  final bool? inline;

  @override
  Widget build(BuildContext context) {
    late TextStyle? inPutStyle;
    if (headerStyle == null) {
      inPutStyle = TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade700);
    } else {
      inPutStyle = headerStyle;
    }
    if (inline == null || inline == false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: inPutStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          )
        ],
      );
    }
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: inPutStyle,
        ),
        child
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: child,
        // )
      ],
    );
  }
}

class CustomloseButton extends StatelessWidget {
  const CustomloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.times),
      onPressed: () {
        Navigator.maybePop(context);
      },
    );
  }
}
