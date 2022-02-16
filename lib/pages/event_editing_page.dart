import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/EventProvider.dart';
import 'package:world_time/utilities/Utils.dart';
import 'package:world_time/utilities/Event.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  late Color color;

  final headerStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 20);

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
      color = Colors.grey;
    } else {
      final event = widget.event!;
      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
      color = event.backgroundColor;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: CloseButton(),
        actions: builEditingActions(),
        backgroundColor: color,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(
                height: 20,
              ),
              buildDateTimePickers(),
              colorPick(header: 'color'),
              SizedBox(
                height: 20,
              ),
              buildDescription(),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> builEditingActions() {
    return [
      ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0),
          onPressed: saveForm,
          icon: Icon(FontAwesomeIcons.check),
          label: Text('Save'))
    ];
  }

  Widget buildTitle() {
    return TextFormField(
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
          border: UnderlineInputBorder(), hintText: 'Add a title'),
      onFieldSubmitted: (_) => saveForm(),
      controller: titleController,
      validator: (title) {
        return title == null || title.isEmpty ? 'Title is empty' : null;
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
                pickerDateTime(pickingFrom: false, pickDate: false),
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
          headerStyle: headerStyle,
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

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
          id: widget.event?.id,
          title: titleController.text,
          description: descriptionController.text,
          from: fromDate,
          to: toDate,
          isAllDay: false,
          backgroundColor: color);
      final isEditing = widget.event != null;

      final provider = Provider.of<EventProvider>(context, listen: false);
      if (isEditing) {
        print('ID' +
            widget.event!.id.toString() +
            event.title +
            ' ' +
            event.description +
            event.id.toString() +
            event.backgroundColor.toString() +
            event.from.toIso8601String());
        provider.editEvent(event, widget.event!);
      } else {
        provider.addEvent(event);
      }
      Navigator.of(context).pop();
    }
  }

  Widget colorPick({required String header}) => buildHeader(
      header: header,
      headerStyle: headerStyle,
      child: Row(children: [
        BlockPicker(
            layoutBuilder: (context, colors, child) {
              Orientation orientation = MediaQuery.of(context).orientation;
              int _portraitCrossAxisCount = 8;
              int _landscapeCrossAxisCount = 8;
              return SizedBox(
                width: 300,
                height: orientation == Orientation.portrait ? 50 : 40,
                child: GridView.count(
                  padding: EdgeInsets.all(20),
                  crossAxisCount: orientation == Orientation.portrait
                      ? _portraitCrossAxisCount
                      : _landscapeCrossAxisCount,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: [for (Color color in colors) child(color)],
                ),
              );
            },
            itemBuilder: (color, isCurrentColor, changeColor) => InkWell(
                  child: Container(
                    width: 5,
                    height: 5,
                    color: color,
                  ),
                  onTap: changeColor,
                ),
            pickerColor: color,
            availableColors: Event.colorList,
            onColorChanged: (output) {
              setState(() {});
              print(output.value);
              color = output;
            }),
      ]));

  Widget buildDescription() => TextFormField(
        maxLines: 4,
        minLines: 3,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(3))),
            hintText: 'Description'),
        onFieldSubmitted: (_) => saveForm(),
        controller: descriptionController,
        // validator: (title) {
        //   return title == null || title.isEmpty ? 'Title is empty' : null;
        // },
      );
}
