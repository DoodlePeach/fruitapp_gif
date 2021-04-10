import 'package:flutter/foundation.dart';
import 'package:fruitapp/Database/DatabaseHelper.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderModel extends ChangeNotifier {
  CalendarController _controller = new CalendarController();
  bool isCalenderOpen = false;
  Map<DateTime, List<dynamic>> datesWithFruits = {};

  CalendarController get controller => _controller;

  CalenderModel() {
    refreshEvents();
  }

  void onDateSelected(DateTime time, List<dynamic> a, List<dynamic> b) {
    print(time);
  }

  void refreshEvents() {
    DatabaseQuery.db.getAllDates().then((List<DateTime> dates) {
      dates.forEach((DateTime element) {
        datesWithFruits[element] = [true];
      });

      notifyListeners();
    });
  }
}
