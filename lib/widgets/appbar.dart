import 'package:flutter/material.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:provider/provider.dart';

AppBar appBar = AppBar(
  actions: [
    IconButton(icon: Icon(Icons.calendar_today_outlined), onPressed: () {}),
    IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
  ],
  title: Consumer<DayModel>(
    builder: (_, data, __) {
      return Text(
          "${data.currentDate.day}/${data.currentDate.month}/${data.currentDate.year}");
    },
  ),
  leading: IconButton(
    icon: Icon(Icons.menu),
    onPressed: () {},
  ),
);
