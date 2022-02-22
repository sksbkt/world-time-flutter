import 'dart:ffi';

import 'package:flutter/material.dart';

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
      inPutStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    } else {
      inPutStyle = headerStyle;
    }
    print(inline);
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
}
