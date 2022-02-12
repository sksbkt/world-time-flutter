import 'package:flutter/cupertino.dart';
import 'package:world_time/utilities/Event.dart';
import 'package:world_time/widgets/Modules/DB/Events_DataBase.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  // List<Event> get events => _events;
  Future<List<Event>> get events async {
    print('reading events');
    return await EventsDatabase.instance.readAllEvent();
  }

  DateTime _selectedDate = DateTime.now();
  DateTime get seletedDate => _selectedDate;
  DateTime setDate(DateTime date) => _selectedDate = date;
  List<Event> get eventsOfSelectedDate => _events;

  void addEvent(Event event) {
    EventsDatabase.instance.create(event).then((value) {
      print(value.id);
      notifyListeners();
    });
    // _events.add(event);
    // notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    EventsDatabase.instance.update(newEvent).then((value) {
      notifyListeners();
    });

    // final index = events.indexOf(oldEvent);
    // events[index] = newEvent;
  }

  void deleteEvent(Event event) {
    EventsDatabase.instance.delete(event.id).then((value) {
      print('removed ' + value.toString());
      notifyListeners();
    });
  }
}
