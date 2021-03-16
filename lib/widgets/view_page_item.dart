import 'package:flutter/material.dart';
import 'mlkg_dialog.dart';

// The selections a user can make when they click on the option button
// present at the right side of ViewPageItemWidget.
enum PopupSelection { statistics, change, delete }

class ViewPageItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                          "watermelon",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("blue color",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))
                      ],
                    ),
                    TextField(
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
