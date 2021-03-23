import 'package:flutter/material.dart';
import 'package:fruitapp/Dialog/NameFruitDialog.dart';
import 'package:fruitapp/Dialog/SubCategoryFruitDialog.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:fruitapp/models/fruit_model.dart';
import 'package:fruitapp/widgets/mlkg.dart';
import 'package:fruitapp/widgets/mlkg_dialog.dart';
import 'package:provider/provider.dart';

import '../Fruit.dart';
import '../assets.dart';

// The selections a user can make when they click on the option button
// present at the right side of ViewPageItemWidget.
enum PopupSelection { statistics, change, delete }

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Fruit fruit = ModalRoute.of(context).settings.arguments;
    fruit = Provider.of<FruitModel>(context, listen: false).getReference(fruit);
    _controller.text = fruit.comment;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.calendar_today_outlined),
              onPressed: () {
                Navigator.pushNamed(context, '/calender');
              }),
          PopupMenuButton(
            onSelected: (PopupSelection result) async {
              if (result == PopupSelection.change) {
                showDialog(
                        context: context,
                        builder: (_) => NameFruitDialog.forUpdate(fruit))
                    .then((value) => () {
                          SubNameFruitDialog.newFruitSelectedForUpdate = null;
                          NameFruitDialog.updated = false;
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
      ),
      body: Consumer<FruitModel>(
        builder: (_, data, __) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(fruit.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(7),
                      child: Column(
                        children: [
                          Image.asset(
                              basePath +
                                  fruit.name.toLowerCase() +
                                  "/" +
                                  paths[fruit.name.toLowerCase()]["variants"]
                                      [fruit.type.toLowerCase()],
                              height: 220),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                fruit.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(fruit.type,
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "comments"),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: fruit.mlkg.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AddMLKGDialog(
                                      fruit: fruit, mlkg: fruit.mlkg[index]);
                                }).then((value) => setState(() {}));
                          },
                          child: MLKGWidget(
                            kg: fruit.mlkg[index].kg != null
                                ? fruit.mlkg[index].kg
                                : "-",
                            ml: fruit.mlkg[index].ml != null
                                ? fruit.mlkg[index].ml
                                : "-",
                            no: index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AddMLKGDialog(fruit: fruit);
                          });
                    }),
                Container(
                  padding: EdgeInsets.all(7),
                  height: 80,
                  alignment: Alignment.bottomCenter,
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      child: Text("UPDATE"),
                      onPressed: () {
                        fruit.comment = _controller.text;
                        FruitModel model =
                            Provider.of<FruitModel>(context, listen: false);

                        model.updateFruit(fruit).then((value) => model.refresh(
                            Provider.of<DayModel>(context, listen: false)
                                .currentDate));
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
