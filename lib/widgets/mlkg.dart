import 'package:flutter/material.dart';

class MLKGWidget extends StatelessWidget {
  final ml, kg;

  MLKGWidget({@required this.kg, @required this.ml});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text("KG"),
                    SizedBox(
                      width: 5,
                    ),
                    Text(kg)
                  ],
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text("ML"),
                    SizedBox(
                      width: 5,
                    ),
                    Text(ml)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
