import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final String tableEvents = 'events';

class EventFields {
  static final List<String> values = [
    id,
    isAllDay,
    title,
    description,
    backgroundColor,
    from,
    to,
  ];
  static final String id = '_id';
  static final String isAllDay = 'isAllDay';
  static final String title = 'title';
  static final String description = 'description';
  static final String backgroundColor = 'backgroundColor';
  static final String from =
      'fromDate'; //from is reserved word in sql, be careful while working around reserved words
  static final String to = 'toDate';
}

class Event {
  final int? id;
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;
  static List<Color> colorList = [
    Colors.grey,
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.yellow.shade600,
    Colors.orange,
    Colors.purple,
    Colors.pink,
  ];

  Event(
      {this.id,
      required this.title,
      required this.description,
      required this.from,
      required this.to,
      this.backgroundColor = Colors.lightGreen,
      this.isAllDay = false});
  Map<String, Object?> toJson() => {
        EventFields.id: id,
        EventFields.title: title,
        EventFields.description: description,
        EventFields.isAllDay: isAllDay ? 1 : 0,
        EventFields.backgroundColor: backgroundColor.value.toString(),
        EventFields.from: from.toIso8601String(),
        EventFields.to: to.toIso8601String(),
      };
  Event copy(
          {int? id,
          String? title,
          String? description,
          DateTime? from,
          DateTime? to,
          Color? backgroundColor,
          bool? isAllDay}) =>
      Event(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isAllDay: isAllDay ?? this.isAllDay,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        from: from ?? this.from,
        to: to ?? this.to,
      );
  static Event fromJson(
    Map<String, Object?> json,
  ) =>

      /// since we save our Booleans as string on our database, we need to convert them back.
      Event(
        id: json[EventFields.id] as int?,
        title: json[EventFields.title] as String,
        description: json[EventFields.description] as String,
        isAllDay: json[EventFields.isAllDay] == 1,
        backgroundColor: Color(
            int.tryParse(json[EventFields.backgroundColor] as String) ?? 0),

        /// since we save our Datetime as string on our database, we need to convert them back.
        from: DateTime.parse(json[EventFields.from] as String),
        to: DateTime.parse(json[EventFields.to] as String),
      );
  static Event appointmentToEvent(Appointment input) {
    return new Event(
        id: int.parse(input.id.toString()),
        title: input.subject,
        description: input.notes ?? '',
        isAllDay: input.isAllDay,
        from: input.startTime,
        to: input.endTime,
        backgroundColor: input.color);
  }

  static String formatDate(DateTime input) {
    return DateFormat('MM/dd/yyyy - hh:mm').format(input);
  }
}
