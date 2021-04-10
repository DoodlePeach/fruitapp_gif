import 'package:flutter/material.dart';
import 'package:fruitapp/models/calender_model.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:fruitapp/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
      body: Container(child: Consumer<CalenderModel>(
        builder: (context, data, child) {
          return TableCalendar(
            calendarController: data.controller,
            initialSelectedDay:
                Provider.of<DayModel>(context, listen: false).currentDate,
            onDaySelected: (DateTime selected, _, __) {
              Provider.of<DayModel>(context, listen: false)
                  .setNewDate(selected);
              Navigator.pushNamed(context, '/day');
            },
            events: data.datesWithFruits,
          );
        },
      )),
    );
  }
}
