import 'package:flutter/material.dart';
import 'package:fruitapp/models/calender_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalendarController calendarController =
        Provider.of<CalenderModel>(context, listen: false).controller;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.calendar_today_outlined), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
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
