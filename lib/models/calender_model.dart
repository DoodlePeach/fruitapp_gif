import 'package:flutter/foundation.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderModel extends ChangeNotifier {
  CalendarController _controller = new CalendarController();

  CalendarController get controller => _controller;

  void onDateSelected(DateTime time, List<dynamic> a, List<dynamic> b) {
    print(time);
  }
}
