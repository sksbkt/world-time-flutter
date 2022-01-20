import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:world_time/utilities/Utils.dart';
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
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(
              height: 20,
            ),
            buildDateTimePickers(),
          ],
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
          border: UnderlineInputBorder(), hintText: 'Add title'),
      onFieldSubmitted: (_) {},
      controller: titleController,
      validator: (title) {
        return title != null && title.isNotEmpty ? 'Title is empty' : null;
      },
    );
  }

  Widget buildDateTimePickers() => Column(
        children: [
          SizedBox(
            height: 5,
          ),
          buildFrom(
            header: 'From',
            dateTime: fromDate,
            OnTapStarting: () =>
                pickerDateTime(pickingFrom: true, pickDate: true),
            OntapEnding: () =>
                pickerDateTime(pickingFrom: true, pickDate: false),
          ),
          buildFrom(
            header: 'to',
            dateTime: toDate,
            OnTapStarting: () =>
                pickerDateTime(pickingFrom: false, pickDate: true),
            OntapEnding: () =>
                pickerDateTime(pickingFrom: false, pickDate: true),
          )
          // buildTo()
        ],
      );
  Widget buildFrom({
    required String header,
    required DateTime dateTime,
    required VoidCallback OnTapStarting,
    required VoidCallback OntapEnding,
  }) =>
      buildHeader(
          header: header,
          headerStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: buildDropDownField(
                      text: Utils.toDate(dateTime), onClicked: OnTapStarting)),
              Expanded(
                  flex: 1,
                  child: buildDropDownField(
                      text: Utils.toTime(dateTime), onClicked: OntapEnding)),
            ],
          ));
  // Widget buildTo() => buildHeader(
  //     header: 'To',
  //     headerStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
  //     child: Row(
  //       children: [
  //         Expanded(
  //             flex: 2,
  //             child: buildDropDownField(
  //                 text: Utils.toDate(toDate), onClicked: () {})),
  //         Expanded(
  //             flex: 1,
  //             child: buildDropDownField(
  //                 text: Utils.toTime(toDate), onClicked: () {})),
  //       ],
  //     ));
  Widget buildDropDownField(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );
  Widget buildHeader(
          {required String header,
          required Widget child,
          TextStyle? headerStyle}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              header,
              style: headerStyle,
            ),
          ),
          child
        ],
      );

  Future pickerDateTime(
      {required bool pickingFrom, required bool pickDate}) async {
    if (pickingFrom) {
      final date = await pickDateTime(fromDate, pickDate: pickDate);
      if (date == null) return;
      if (date.isAfter(toDate)) {
        toDate = date;
      }
      setState(() {
        fromDate = date;
      });
    } else {
      final date =
          await pickDateTime(toDate, pickDate: pickDate, firstDate: fromDate);
      if (date == null) return;
      setState(() {
        toDate = date;
      });
    }
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015),
          lastDate: DateTime(2101));
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }
}
