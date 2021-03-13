import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Card/GridCard.dart';
import '../Card/GridDataModel.dart';

class NameFruitDialog extends StatefulWidget {
  static String date;

  NameFruitDialog(String date) {
    NameFruitDialog.date = date;
  }

  @override
  _nameFruitDialog createState() => _nameFruitDialog();
}

class _nameFruitDialog extends State<NameFruitDialog> {
  List<GridCard> list = [
    GridCard(new GridCardModel("Apple", "", "assets/testimage.jpeg")),
    GridCard(new GridCardModel("Banana", "", "assets/testimage.jpeg")),
    GridCard(new GridCardModel("Water Melon", "", "assets/testimage.jpeg")),
    GridCard(new GridCardModel("Avocado", "", "assets/testimage.jpeg")),
    GridCard(new GridCardModel("Apricots", "", "assets/testimage.jpeg")),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Center(
            child: Text(
          "Name Fruit",
          style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.04),
        )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.68,
          child: Container(
            color: Colors.white,
            child: GridView.count(
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                childAspectRatio: (1 / 1.3),
                children: list),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: RaisedButton(
                color: Colors.red,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 15),
                )),
          ),
        )
      ]),
    );
  }
}
