import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/EventProvider.dart';
import 'package:world_time/utilities/Utils.dart';
import 'package:world_time/utilities/Event.dart';

import '../widgets/Modules/UI/UiHelper.dart';

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
  final scrollController = ScrollController();
  late DateTime fromDate;
  late DateTime toDate;
  late bool allDayLong;
  late Color color;

  bool reversed = true;

  final headerStyle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey.shade700);
  final hintStyle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w500, color: Colors.grey.shade600);

  @override
  void initState() {
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
      color = Colors.redAccent;
      allDayLong = false;
    } else {
      final event = widget.event!;
      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
      color = event.backgroundColor;
      allDayLong = event.isAllDay;
    }
    print('init state: ' + allDayLong.toString());
    super.initState();
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
        leading: CustomloseButton(),
        actions: builEditingActions(),
        backgroundColor: color,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: scrollController,
            reverse: reversed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                buildTitle(),
                SizedBox(
                  height: 10,
                ),
                buildDateTimePickers(),
                SizedBox(
                  height: 10,
                ),
                //TODO: code must be hooked
                buildAllDayLong(),
                SizedBox(
                  height: 10,
                ),
                buildColorPickerDialog(context),
                // colorPick(),
                // SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                  height: 10,
                ),
                buildDescription(),

                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAllDayLong() {
    return HeaderBuilder(
        header: 'All day long:',
        inline: true,
        child: Flexible(
            child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: null,
                value: allDayLong,
                onChanged: (value) {
                  allDayLong = value ?? false;
                  print(allDayLong);
                  setState(() {});
                })));
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
          label: Text(
            'Save',
            style: TextStyle(fontSize: 18),
          ))
    ];
  }

  Widget buildTitle() {
    return TextFormField(
      onTap: () {
        reversed = false;
        setState(() {});
        scrollController.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.easeOut);
      },
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add a title',
          hintStyle: hintStyle),
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
            header: 'To',
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
      HeaderBuilder(
          header: header,
          // headerStyle: headerStyle,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: buildDropDownField(
                      text: Utils.toDate(dateTime), onClicked: OnTapStarting)),
              Expanded(
                  flex: 2,
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
          isAllDay: allDayLong,
          backgroundColor: color);
      final isEditing = widget.event != null;

      final provider = Provider.of<EventProvider>(context, listen: false);
      if (isEditing) {
        print('ID ' +
            allDayLong.toString() +
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

  Widget buildColorPickerDialog(BuildContext context) {
    return HeaderBuilder(
      header: 'Color:',
      inline: true,
      child: Flexible(
        child: GestureDetector(
          onTapUp: (TapUpDetails detail) {
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;
            double x = toAlignValue(detail.globalPosition.dx, width);
            double y = toAlignValue(detail.globalPosition.dy, height);
            showDialog(
                context: context,
                builder: (context) => Align(
                    alignment: Alignment(0, y),
                    child: AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        content: Material(child: colorPick()))));
          },
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: color),
            // color: color,
            height: 40,
            width: 40,
          ),
        ),
      ),
    );
  }

  Widget colorPick() => BlockPicker(
      layoutBuilder: (context, colors, child) {
        // Orientation orientation = MediaQuery.of(context).orientation;
        // int _portraitCrossAxisCount = 4;
        // int _landscapeCrossAxisCount = 4;
        return Container(
          width: 300,
          // orientation == Orientation.portrait ? 100 : 60,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            // padding: EdgeInsets.all(10),
            crossAxisCount: 4,
            // orientation == Orientation.portrait
            //     ? _portraitCrossAxisCount
            //     : _landscapeCrossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [for (Color color in colors) child(color)],
          ),
        );
      },
      itemBuilder: (color, isCurrentColor, changeColor) => InkWell(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
            onTap: changeColor,
          ),
      pickerColor: color,
      availableColors: Event.colorList,
      onColorChanged: (output) {
        setState(() {});
        color = output;
        Navigator.pop(context);
      });

  Widget buildDescription() => TextFormField(
        onTap: () {
          reversed = true;
          setState(() {});
          scrollController.animateTo(0,
              duration: Duration(seconds: 1), curve: Curves.easeOut);
        },
        maxLines: 4,
        minLines: 3,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(3))),
            hintText: 'Description',
            hintStyle: hintStyle),
        onFieldSubmitted: (_) => saveForm(),
        controller: descriptionController,
        // validator: (title) {
        //   return title == null || title.isEmpty ? 'Title is empty' : null;
        // },
      );
}

double toAlignValue(double inputTap, double screenSize) {
  double mid = screenSize / 2;
  double tapPos = inputTap / screenSize;
  print(tapPos.toString());

  return inputTap > mid ? tapPos : tapPos - 1;
}
