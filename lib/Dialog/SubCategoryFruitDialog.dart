import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Database/DatabaseHelper.dart';
import '../Card/GridCard.dart';
import 'NameFruitDialog.dart';
import '../Fruit.dart';
import '../Card/GridDataModel.dart';

class SubNameFruitDialog extends StatefulWidget {
  List<GridCard> list;

  SubNameFruitDialog(this.list);

  static List<GridCardModel> selectedList = new List<GridCardModel>();

  @override
  _SnameFruitDialog createState() => _SnameFruitDialog();
}

class _SnameFruitDialog extends State<SubNameFruitDialog> {
  @override
  void initState() {
    super.initState();
    SubNameFruitDialog.selectedList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(alignment:Alignment.topLeft,child: Icon(Icons.arrow_back)),
            Center(
              child: Text(
                widget.list[0].gridCardModel.name,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.04),
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.68,
          child: Container(
            color: Colors.white,
            child: GridView.count(
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                childAspectRatio: (1 / 1.3),
                children: widget.list),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton(
                color: Colors.red,
                onPressed: () {
                  SubNameFruitDialog.selectedList.clear();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 15),
                )),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: RaisedButton(
                  color: Colors.lightGreen,
                  onPressed: () async {
                    String fruitColors="";

                    for (int i = 0;i < SubNameFruitDialog.selectedList.length; i++) {
                      print(SubNameFruitDialog.selectedList[i].type);
                      // Here We can add food which exist in selectedList by calling Database AddFruit Method
                      Fruit newFruit = new Fruit(SubNameFruitDialog.selectedList[i].name,SubNameFruitDialog.selectedList[i].type,"",NameFruitDialog.date,null);
                      var result = await DatabaseQuery.db.newFruit(newFruit);
                      if(!result){
                        fruitColors = fruitColors + newFruit.type +"\n";
                      }
                    }

                    if(fruitColors!=""){
                      final result = await showDialog(
                        context: context,
                        builder: (_) => Dialog(child: Column(
                          children: [
                          Text("Following types already exists:"),
                          Text(fruitColors),
                          RaisedButton(onPressed: (){
                            Navigator.of(context).pop();},
                           child: Text("Ok"),
                          )
                        ],))
                      );
                    }
                    //After adding food in database clear the selected List and pop out
                    SubNameFruitDialog.selectedList.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: 15),
                  )),
            ),
          ],
        )
      ]),
    );
  }
}
