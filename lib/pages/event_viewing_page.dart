import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:world_time/pages/event_editing_page.dart';
import 'package:world_time/services/EventProvider.dart';
import 'package:world_time/utilities/Event.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;
  const EventViewingPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Event view'),
            leading: CloseButton(
              color: Colors.white,
            ),
            actions: buildViewingActions(
              context,
              event,
            )),
        body: ListView(
          padding: EdgeInsets.all(5),
          children: [
            Text(
              event.title,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              event.description,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              Event.formatDate(event.from),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              Event.formatDate(event.to),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              event.isAllDay ? 'all day long' : 'not all day long',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ));
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) {
    return [
      IconButton(
          onPressed: () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => EventEditingPage(
                        event: event,
                      ))),
          icon: Icon(Icons.edit)),
      IconButton(
          onPressed: () {
            final provider = Provider.of<EventProvider>(context, listen: false);
            provider.deleteEvent(event);
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.delete)),
    ];
  }
}
