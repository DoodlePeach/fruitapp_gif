import 'package:flutter/material.dart';
import 'package:fruitapp/models/calender_model.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:provider/provider.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            icon: Icon(Icons.calendar_today_outlined),
            onPressed: () {
              CalenderModel calenderModel =
                  Provider.of<CalenderModel>(context, listen: false);

              if (ModalRoute.of(context).settings.name == "/calender" &&
                  calenderModel.isCalenderOpen) {
                Navigator.pop(context);
                calenderModel.isCalenderOpen = false;
              } else {
                calenderModel.refreshEvents();
                Navigator.pushNamed(context, '/calender');
                calenderModel.isCalenderOpen = true;
              }
            }),
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
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
