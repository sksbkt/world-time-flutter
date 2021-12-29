import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget(
      {Key? key,
      required this.Text,
      required this.onChanged,
      required this.hintText})
      : super(key: key);

  final String Text;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.Text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.black26)),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            icon: Icon(
              FontAwesomeIcons.search,
              color: style.color,
            ),
            suffixIcon: widget.Text.isNotEmpty
                ? GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: style.color,
                    ),
                    onTap: () {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: style,
            border: InputBorder.none),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
