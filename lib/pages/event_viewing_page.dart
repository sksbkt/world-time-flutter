import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:world_time/pages/event_editing_page.dart';
import 'package:world_time/services/EventProvider.dart';
import 'package:world_time/utilities/Event.dart';
import 'package:world_time/widgets/Modules/UI/UiHelper.dart';

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
          padding: const EdgeInsets.all(23),
          children: [
            HeaderBuilder(
              header: 'Title',
              child: Text(
                event.title,
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            HeaderBuilder(
              header: 'From:',
              inline: true,
              child: Text(
                Event.formatDate(event.from),
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            HeaderBuilder(
              header: 'To:',
              inline: true,
              child: Text(
                Event.formatDate(event.to),
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            HeaderBuilder(
              header: 'All day long:',
              inline: true,
              child: Text(
                event.isAllDay ? 'Yes' : 'No',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              event.description,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ));
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) {
    return [
      IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => EventEditingPage(
                      event: event,
                    )));
          },
          icon: Icon(Icons.edit)),
      IconButton(
          onPressed: () {
            showAlertDialog(
                context: context,
                onAccept: () {
                  final provider =
                      Provider.of<EventProvider>(context, listen: false);
                  provider.deleteEvent(event);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
          },
          icon: Icon(Icons.delete)),
    ];
  }

  showAlertDialog({
    required BuildContext context,
    required VoidCallback onAccept,
  }) {
    Widget cancelButton = IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.close_outlined));
    Widget acceptButton =
        IconButton(onPressed: onAccept, icon: Icon(Icons.check));

    AlertDialog alert = AlertDialog(
      content: Text('Are you sure you want to delete this appointment?'),
      actions: [cancelButton, acceptButton],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
