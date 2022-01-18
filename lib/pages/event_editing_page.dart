import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:world_time/utilities/event.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: builEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [buildTitle()],
        ),
      ),
    );
  }

  List<Widget> builEditingActions() {
    return [
      ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, shadowColor: Colors.transparent),
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.check),
          label: Text('Save'))
    ];
  }

  Widget buildTitle() {
    return TextFormField(
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
          border: UnderlineInputBorder(), hintText: 'Enter a title'),
      onFieldSubmitted: (_) {},
      controller: titleController,
      validator: (title) {
        return title != null && title.isNotEmpty ? 'Title is empty' : null;
      },
    );
  }
}
