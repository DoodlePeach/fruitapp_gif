import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitapp/Database/DatabaseHelper.dart';
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
  // This controller takes input from the user when they enter thier comments.
  TextEditingController _controller = new TextEditingController();
  CarouselController _carouselController = new CarouselController();
  CategorySize categorySize;

  @override
  Widget build(BuildContext context) {
    // Extract the arguments (i.e the fruit that has been selected) from the
    // route.
    Fruit fruit = ModalRoute.of(context).settings.arguments;

    TimerApp.time = fruit.time;

    // Text field is initialized with the comments that may have been previously
    // added by the user.
    _controller.text = fruit.comment;

    return Consumer<FruitModel>(
      builder: (_, data, __) {
        return FutureBuilder(
            // Every time the an update is performed in the database on the
            // fruit, the Consumer remakes the FutureBuilder, which in turn
            // reads the fruit from the database again.
            // This helps in synchronization, otherwise what is actually present
            // in the database and what is shown in the application may be
            // different.
            future: DatabaseQuery.db.getFruit(fruit.id),
            builder: (context, AsyncSnapshot<Fruit> snapshot) {
              // Show an indeterminate progress indicator when no data has
              // yet been fetched.
              if (!snapshot.hasData)
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              String fruitName = snapshot.data.name.toLowerCase();
              String fruitColor = snapshot.data.type.toLowerCase();

              List<String> items =
                  details[fruitName]["variants"].values.toList();

              int index = items.indexOf(snapshot.data.gif);

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Text(snapshot.data.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(7),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CarouselSlider(
                                      carouselController: _carouselController,
                                      options: CarouselOptions(
                                          height: 220.0, initialPage: index),
                                      items: items.map<Widget>((i) {
                                        return Image.asset(
                                            basePath + fruitName + "/" + i);
                                      }).toList(),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.chevron_left),
                                              onPressed: () {
                                                _carouselController
                                                    .previousPage();
                                              }),
                                          IconButton(
                                              icon: Icon(Icons.chevron_right),
                                              onPressed: () {
                                                _carouselController.nextPage();
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Image paths are stored in assets.dart.
                                // Image.asset(
                                //     basePath +
                                //         snapshot.data.name.toLowerCase() +
                                //         "/" +
                                //         details[snapshot.data.name
                                //                 .toLowerCase()]["variants"]
                                //             [snapshot.data.type.toLowerCase()],
                                //     height: 220),
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
                                ),

                                Divider(),

                                // Custom expandable widget from the
                                // expandable package.
                                // Basically a Column, with a text field
                                // and a different icon depending upon the
                                // collapsed state.
                                // Expandable Notifier listens and
                                // changes the state of
                                // the widget whe Expandable Button is pressed.
                                ExpandableNotifier(
                                    child: Column(
                                  children: [
                                    Expandable(
                                        collapsed: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                              child:
                                                  // Unexpanded text field is clipped
                                                  // at 2 lines.
                                                  Text(
                                                // Description is static and stored in assets.dart
                                                details[snapshot.data.name
                                                            .toLowerCase()]
                                                        ["description"][
                                                    snapshot.data.type
                                                        .toLowerCase()],
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            // Expandable button tells the
                                            // expandable notifier to change
                                            // states.
                                            ExpandableButton(
                                              child: Icon(
                                                  Icons.keyboard_arrow_down),
                                            )
                                          ],
                                        ),
                                        expanded: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),

                                              // Description is static and stored in assets.dart
                                              child: Text(details[snapshot
                                                          .data.name
                                                          .toLowerCase()]
                                                      ["description"][
                                                  snapshot.data.type
                                                      .toLowerCase()]),
                                            ),
                                            ExpandableButton(
                                              child:
                                                  Icon(Icons.keyboard_arrow_up),
                                            )
                                          ],
                                        ))
                                  ],
                                )),
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
                                        return AddUpdateMLKGDialog(
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
                                  no: index + 1,
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
                                    return AddUpdateMLKGDialog(
                                        fruit: snapshot.data);
                                  });
                            }),
                        categorySize = CategorySize(
                            selected: snapshot.data.categorySize,
                            clickEnable: true),
                      ]),
                      Container(
                        padding: EdgeInsets.all(7),
                        height: 80,
                        alignment: Alignment.bottomCenter,
                        child: SizedBox.expand(
                          child: ElevatedButton(
                            child: Text("UPDATE"),
                            onPressed: () {
                              // Update the data, then

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
