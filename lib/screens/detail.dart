import 'package:flutter/material.dart';
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
    TimerApp.time =  "00:00:00";
    if (firstBuild) {
      _controller.text = fruit.comment;
      firstBuild = false;
    }

    return Consumer<FruitModel>(
      builder: (_, data, __) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                fruit.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: Center(child: TimerApp()),
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
                              return AddMLKGDialog(fruit: fruit);
                            });
                      }),
                  categorySize =
                      CategorySize(selected: "None", clickEnable: true),
                ]),
                Container(
                  padding: EdgeInsets.all(7),
                  height: 80,
                  alignment: Alignment.bottomCenter,
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      child: Text("UPDATE"),
                      onPressed: () {
                        fruit.comment = _controller.text;
                        fruit.categorySize = categorySize.selected;
                        fruit.time = TimerApp.time;
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
          ),
        );
      },
    );
  }
}
