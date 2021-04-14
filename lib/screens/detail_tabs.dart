import 'package:flutter/material.dart';
import 'package:fruitapp/Dialog/NameFruitDialog.dart';
import 'package:fruitapp/Dialog/SubCategoryFruitDialog.dart';
import 'package:fruitapp/models/calender_model.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:fruitapp/models/fruit_model.dart';
import 'package:fruitapp/screens/detail.dart';
import 'package:fruitapp/screens/statistics.dart';
import 'package:fruitapp/widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../Fruit.dart';

class DetailTabsPage extends StatefulWidget {
  @override
  _DetailTabsPageState createState() => _DetailTabsPageState();
}

class _DetailTabsPageState extends State<DetailTabsPage> {
  bool firstBuild = true;

  @override
  Widget build(BuildContext context) {
    Fruit fruit = ModalRoute.of(context).settings.arguments;
    fruit = Provider.of<FruitModel>(context, listen: false).getReference(fruit);

    List<int> itemNumbers = [];
    List<String> kgInItems = [];
    List<String> mlInItems = [];

    fruit.mlkg.forEach((element) {
      itemNumbers.add(element.id);
      kgInItems.add(element.kg);
      mlInItems.add(element.ml);
    });

    if (firstBuild) firstBuild = false;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // Refer to appbar.dart for info, most of this is same.
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

              // Refer to ViewPageItem.dart for detail for this popup button
              // This button is the same as the 'more' button there.
              PopupMenuButton(
                onSelected: (PopupSelection result) async {
                  if (result == PopupSelection.change) {
                    showDialog(
                            context: context,
                            builder: (_) => NameFruitDialog.forUpdate(fruit))
                        .then((value) => () {
                              SubNameFruitDialog.newFruitSelectedForUpdate =
                                  null;
                              NameFruitDialog.updated = false;
                              Provider.of<FruitModel>(context, listen: false)
                                  .refresh(Provider.of<DayModel>(context,
                                          listen: false)
                                      .currentDate);
                            });
                  } else if (result == PopupSelection.statistics) {
                  } else {
                    Provider.of<FruitModel>(context, listen: false)
                        .deleteFruit(fruit)
                        .then((value) {
                      Provider.of<FruitModel>(context, listen: false).refresh(
                          Provider.of<DayModel>(context, listen: false)
                              .currentDate);
                      Navigator.pop(context);
                    });
                  }
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<PopupSelection>>[
                  const PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.bar_chart),
                      title: Text("Information"),
                    ),
                    value: PopupSelection.statistics,
                  ),
                  const PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.refresh),
                      title: Text("Change to another"),
                    ),
                    value: PopupSelection.change,
                  ),
                  const PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.clear),
                      title: Text("Remove Fruit"),
                    ),
                    value: PopupSelection.delete,
                  ),
                ],
              )
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
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Information',
                ),
                Tab(
                  text: 'Statistics',
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                DetailPage(),
                Statistics(),
              ],
            ),
          ),
        ));
  }
}
