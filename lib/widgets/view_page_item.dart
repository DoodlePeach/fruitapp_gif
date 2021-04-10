import 'package:flutter/material.dart';
import 'package:fruitapp/Dialog/NameFruitDialog.dart';
import 'package:fruitapp/Dialog/SubCategoryFruitDialog.dart';
import 'package:fruitapp/assets.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:fruitapp/models/fruit_model.dart';
import 'package:fruitapp/screens/categorySize.dart';
import 'package:fruitapp/widgets/mlkg.dart';
import 'package:provider/provider.dart';
import '../Fruit.dart';
import 'mlkg_dialog.dart';

// The selections a user can make when they click on the option button
// present at the right side of ViewPageItemWidget.
enum PopupSelection { information, change, delete }

class ViewPageItemWidget extends StatelessWidget {
  final Fruit fruit;
  final TextEditingController commentController = new TextEditingController();

  ViewPageItemWidget({@required this.fruit});

  @override
  Widget build(BuildContext context) {
    commentController.text = fruit.comment == null ? "" : fruit.comment;

    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 50,
                height: 150,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(basePath +
                      fruit.name.toLowerCase() +
                      "/" +
                      paths[fruit.name.toLowerCase()]["variants"]
                          [fruit.type.toLowerCase()]),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          fruit.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(fruit.type,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))
                      ],
                    ),
                    TextField(
                      controller: commentController,
                      decoration: const InputDecoration(hintText: "comments"),
                    ),
                    Flexible(
                      flex: 1,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: fruit.mlkg.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AddMLKGDialog(
                                          fruit: fruit,
                                          mlkg: fruit.mlkg[index]);
                                    });
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
                            // else
                            //   return IconButton(
                            //       alignment: Alignment.centerLeft,
                            //       icon: Icon(Icons.add),
                            //       onPressed: () {
                            //         showDialog(
                            //             context: context,
                            //             builder: (context) {
                            //               return AddMLKGDialog(fruit: fruit);
                            //             });
                            //       });
                          }),
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
                    CategorySize(selected:fruit.categorySize,clickEnable:false),
                  ],
                ),
              ),
              flex: 4,
            ),
            Expanded(
              child: Container(
                width: 55,
                height: 150,
                alignment: Alignment.center,
                child: PopupMenuButton(
                  onSelected: (PopupSelection result) async {
                    if (result == PopupSelection.change) {
                      showDialog(
                              context: context,
                              builder: (_) => NameFruitDialog.forUpdate(fruit))
                          .then((value) => () {
                                SubNameFruitDialog.newFruitSelectedForUpdate =
                                    null;
                                NameFruitDialog.updated = false;
                              });
                    } else if (result == PopupSelection.information) {
                      Navigator.of(context)
                          .pushNamed('/detail', arguments: fruit);
                    } else {
                      Provider.of<FruitModel>(context, listen: false)
                          .deleteFruit(fruit)
                          .then((value) {
                        Provider.of<FruitModel>(context, listen: false).refresh(
                            Provider.of<DayModel>(context, listen: false)
                                .currentDate);
                      });
                    }
                  },
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<PopupSelection>>[
                    const PopupMenuItem(
                      child: ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text("Information"),
                      ),
                      value: PopupSelection.information,
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
                ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
