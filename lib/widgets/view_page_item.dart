import 'package:flutter/material.dart';
import '../Fruit.dart';
import 'mlkg_dialog.dart';

// The selections a user can make when they click on the option button
// present at the right side of ViewPageItemWidget.
enum PopupSelection { statistics, change, delete }

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
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                width: 100,
                height: 150,
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
                    IconButton(
                        alignment: Alignment.centerLeft,
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // TODO: Implement
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AddMLKGDialog();
                              });
                        })
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
                  onSelected: (PopupSelection result) {
                    // TODO: Implement
                  },
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<PopupSelection>>[
                    const PopupMenuItem(
                      child: ListTile(
                        leading: Icon(Icons.graphic_eq),
                        title: Text("Statistics"),
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
