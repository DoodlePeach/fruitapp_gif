import 'package:flutter/material.dart';
import 'package:fruitapp/Database/DatabaseHelper.dart';
import 'package:fruitapp/Dialog/NameFruitDialog.dart';
import 'package:fruitapp/Dialog/SubCategoryFruitDialog.dart';
import 'package:fruitapp/models/calender_model.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:fruitapp/models/fruit_model.dart';
import 'package:fruitapp/screens/categorySize.dart';
import 'package:fruitapp/screens/timer.dart';
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
  bool firstBuild = true;
  CategorySize categorySize;

  @override
  Widget build(BuildContext context) {
    Fruit fruit = ModalRoute.of(context).settings.arguments;
    fruit = Provider.of<FruitModel>(context, listen: false).getReference(fruit);
    TimerApp.time = "00:00:00";
    if (firstBuild) {
      _controller.text = fruit.comment;
      firstBuild = false;
    }

    return Consumer<FruitModel>(
      builder: (_, data, __) {
        return FutureBuilder(
            future: DatabaseQuery.db.getFruit(fruit.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(snapshot.data.name,
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
                                        snapshot.data.name.toLowerCase() +
                                        "/" +
                                        paths[snapshot.data.name.toLowerCase()]
                                                ["variants"]
                                            [snapshot.data.type.toLowerCase()],
                                    height: 220),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(snapshot.data.type,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TimerApp(),
                        ],
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
                            itemCount: snapshot.data.mlkg.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddMLKGDialog(
                                            fruit: snapshot.data,
                                            mlkg: snapshot.data.mlkg[index]);
                                      }).then((value) => setState(() {}));
                                },
                                child: MLKGWidget(
                                  kg: snapshot.data.mlkg[index].kg != null
                                      ? snapshot.data.mlkg[index].kg
                                      : "-",
                                  ml: snapshot.data.mlkg[index].ml != null
                                      ? snapshot.data.mlkg[index].ml
                                      : "-",
                                  no: index+1,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            alignment: Alignment.centerLeft,
                            icon: Icon(Icons.add),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AddMLKGDialog(fruit: snapshot.data);
                                  });
                            }),
                        categorySize =
                            CategorySize(selected: snapshot.data.categorySize, clickEnable: true),
                      ]),
                      Container(
                        padding: EdgeInsets.all(7),
                        height: 80,
                        alignment: Alignment.bottomCenter,
                        child: SizedBox.expand(
                          child: ElevatedButton(
                            child: Text("UPDATE"),
                            onPressed: () {
                              snapshot.data.comment = _controller.text;
                              snapshot.data.categorySize =
                                  categorySize.selected;
                              snapshot.data.time = TimerApp.time;
                              FruitModel model = Provider.of<FruitModel>(
                                  context,
                                  listen: false);

                              model.updateFruit(snapshot.data).then((value) =>
                                  model.refresh(Provider.of<DayModel>(context,
                                          listen: false)
                                      .currentDate));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
