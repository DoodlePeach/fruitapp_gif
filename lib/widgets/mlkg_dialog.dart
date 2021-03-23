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
  final MLKG mlkg;

  AddMLKGDialog({@required this.fruit, this.mlkg});

  @override
  _AddMLKGDialogState createState() => _AddMLKGDialogState();
}

class _AddMLKGDialogState extends State<AddMLKGDialog> {
  TextEditingController ml = new TextEditingController(),
      kg = TextEditingController(),
      comment = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.mlkg != null) {
      kg.text = widget.mlkg.kg;
      ml.text = widget.mlkg.ml;
      comment.text = widget.mlkg.comment;
    }
  }

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
                if (widget.mlkg != null)
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<FruitModel>(context, listen: false)
                            .deleteMLKG(widget.mlkg)
                            .then((value) =>
                                Provider.of<FruitModel>(context, listen: false)
                                    .refresh(Provider.of<DayModel>(context,
                                            listen: false)
                                        .currentDate))
                            .then((value) => Navigator.of(context).pop());
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
                      Navigator.of(context).pop();
                    },
                    child: Text("CANCEL")),
                SizedBox(
                  width: 10,
                ),
                if (widget.mlkg == null)
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
                            .then((value) =>
                                Provider.of<FruitModel>(context, listen: false)
                                    .refresh(Provider.of<DayModel>(context,
                                            listen: false)
                                        .currentDate))
                            .then((value) => Navigator.of(context).pop());
                      },
                      child: Text("ADD"))
                else
                  TextButton(
                      onPressed: () {
                        widget.mlkg.ml = ml.text;
                        widget.mlkg.kg = kg.text;
                        widget.mlkg.comment = comment.text;

                        Provider.of<FruitModel>(context, listen: false)
                            .updateMLKG(widget.fruit)
                            .then((value) =>
                                Provider.of<FruitModel>(context, listen: false)
                                    .refresh(Provider.of<DayModel>(context,
                                            listen: false)
                                        .currentDate))
                            .then((value) => Navigator.of(context).pop());
                      },
                      child: Text("UPDATE"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
