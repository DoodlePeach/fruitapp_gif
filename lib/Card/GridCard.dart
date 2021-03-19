import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Dialog/SubCategoryFruitDialog.dart';
import '../Card/GridDataModel.dart';
import '../assets.dart';

class GridCard extends StatefulWidget {
  final GridCardModel gridCardModel;

  GridCard(this.gridCardModel);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<GridCard> {
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.gridCardModel.type != "") {
          if (isAdded) {
            SubNameFruitDialog.selectedList.remove(widget.gridCardModel);
            setState(() {
              isAdded = false;
            });
          } else {
            SubNameFruitDialog.selectedList.add(widget.gridCardModel);
            setState(() {
              isAdded = true;
            });
          }
        } else {
          List<GridCard> list = [
            GridCard(new GridCardModel(
                widget.gridCardModel.name,
                "Black",
                basePath +
                    widget.gridCardModel.name +
                    "/" +
                    paths[widget.gridCardModel.name]["variants"]["black"])),
            GridCard(new GridCardModel(
                widget.gridCardModel.name,
                "Green",
                basePath +
                    widget.gridCardModel.name +
                    "/" +
                    paths[widget.gridCardModel.name]["variants"]["green"])),
            GridCard(new GridCardModel(
                widget.gridCardModel.name,
                "Blue",
                basePath +
                    widget.gridCardModel.name +
                    "/" +
                    paths[widget.gridCardModel.name]["variants"]["blue"])),
            GridCard(new GridCardModel(
                widget.gridCardModel.name,
                "Red",
                basePath +
                    widget.gridCardModel.name +
                    "/" +
                    paths[widget.gridCardModel.name]["variants"]["red"])),
            GridCard(new GridCardModel(
                widget.gridCardModel.name,
                "Yellow",
                basePath +
                    widget.gridCardModel.name +
                    "/" +
                    paths[widget.gridCardModel.name]["variants"]["yellow"])),
            GridCard(new GridCardModel(
                widget.gridCardModel.name,
                "Orange",
                basePath +
                    widget.gridCardModel.name +
                    "/" +
                    paths[widget.gridCardModel.name]["variants"]["orange"])),
            GridCard(new GridCardModel(
                widget.gridCardModel.name,
                "Grey",
                basePath +
                    widget.gridCardModel.name +
                    "/" +
                    paths[widget.gridCardModel.name]["variants"]["grey"])),
            GridCard(new GridCardModel(
                widget.gridCardModel.name,
                "White",
                basePath +
                    widget.gridCardModel.name +
                    "/" +
                    paths[widget.gridCardModel.name]["variants"]["white"])),
          ];

          final result = await showDialog(
            context: context,
            builder: (_) => SubNameFruitDialog(list),
          );
        }
      },
      child: SizedBox(
        height: double.infinity,
        child: Card(
            shape: isAdded
                ? new RoundedRectangleBorder(
                    side: new BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0))
                : new RoundedRectangleBorder(
                    side: new BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage(widget.gridCardModel.imageSource),
                    height: 130,
                    width: 100,
                    fit: BoxFit.fill),
                Text(widget.gridCardModel.name,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.combine([]))),
                Text(widget.gridCardModel.type),
              ],
            )),
      ),
    );
  }
}
