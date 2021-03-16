import 'package:flutter/material.dart';

class MLKGWidget extends StatelessWidget {
  final ml, kg;

  MLKGWidget({@required this.kg, @required this.ml});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Text("KG"),
              SizedBox(
                width: 5,
              ),
              Text(kg)
            ],
          ),
          Row(
            children: [
              Text("ML"),
              SizedBox(
                width: 5,
              ),
              Text(ml)
            ],
          )
        ],
      ),
    );
  }
}
