import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';

Widget searchResult(String query, String text) {
  if (query.isNotEmpty && text.toLowerCase().contains(query.toLowerCase())) {
    text = text
        .toLowerCase()
        .replaceAll(query.toLowerCase(), '<b>${query.toLowerCase()}</b>');
    if (text.toLowerCase().indexOf(query.toLowerCase()) == 3) {
      String firstChar = text[3].toLowerCase();
      text = text.replaceFirst(firstChar, firstChar.toUpperCase());
    }
  }
  return Html(
    data: text,
    style: {"body": Style(fontSize: FontSize(18))},
  );
}
