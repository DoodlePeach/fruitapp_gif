import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitapp/MLKG.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:fruitapp/models/fruit_model.dart';
import 'package:provider/provider.dart';

import '../Fruit.dart';

// The widget containing the dialog that add/edits mlkg items.
// The dialog returns a Map object when the ADD button is clicked
// with the keys "ml", "kg" and "comment" reflecting the changes
// the user input.
class AddMLKGDialog extends StatefulWidget {
  final Fruit fruit;

  AddMLKGDialog({@required this.fruit});

  @override
  _AddMLKGDialogState createState() => _AddMLKGDialogState();
}

class _AddMLKGDialogState extends State<AddMLKGDialog> {
  TextEditingController ml = new TextEditingController(),
      kg = TextEditingController(),
      comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Number"),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<FruitModel>(context, listen: false)
                          .deleteMLKG(new MLKG(id: widget.fruit.id));
                    }),
              ],
            ),
            Row(
              children: [
                Text("KG"),
                Expanded(
                    child: TextField(
                        controller: kg,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ])),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // TODO: Implement
                    }),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      // TODO: Implement
                    })
              ],
            ),
            Row(
              children: [
                Text("ML"),
                Expanded(
                    child: TextField(
                        controller: ml,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ])),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // TODO: Implement
                    }),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      // TODO: Implement
                    })
              ],
            ),
            Expanded(
              child: TextField(
                controller: comment,
                decoration: InputDecoration(hintText: "Comment"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      // TODO: Implement
                    },
                    child: Text("CANCEL")),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      String inputML = ml.text;
                      String inputKG = kg.text;
                      String inputComment = comment.text;

                      Provider.of<FruitModel>(context, listen: false)
                          .addMLKG(new MLKG(
                              fid: widget.fruit.id,
                              ml: inputML,
                              kg: inputKG,
                              comment: inputComment))
                          .then((value) => Provider.of<FruitModel>(context,
                                  listen: false)
                              .refresh(
                                  Provider.of<DayModel>(context, listen: false)
                                      .currentDate));

                      Navigator.of(context).pop({
                        "ml": inputML,
                        "kg": inputKG,
                        "comment": inputComment
                      });
                    },
                    child: Text("ADD"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
