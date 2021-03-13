import 'package:flutter/material.dart';
import 'package:fruitapp/models/calender_model.dart';
import 'package:fruitapp/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalendarController calendarController =
        Provider.of<CalenderModel>(context, listen: false).controller;

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: TableCalendar(
          calendarController: calendarController,
          onDaySelected:
              Provider.of<CalenderModel>(context, listen: false).onDateSelected,
        ),
      ),
    );
  }
}
