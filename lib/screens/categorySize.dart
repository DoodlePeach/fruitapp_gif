import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategorySize extends StatefulWidget {

  String selected;
  final bool clickEnable;

  CategorySize({this.selected,this.clickEnable});

  @override
  _CategorySize createState() => _CategorySize();
}

class _CategorySize extends State<CategorySize> {
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: widget.selected=="large"?Colors.red:Colors.grey,shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),),
            child: Text("large",),
            onPressed: () {
              setState(() {
                if(widget.clickEnable)
                  widget.selected = "large";
              });}),
        SizedBox(width: 10,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: widget.selected=="middle"?Colors.red:Colors.grey,shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),),
            child: Text("middle"),
            onPressed: () {
              setState(() {
                if(widget.clickEnable)
                  widget.selected = "middle";
              });}),
        SizedBox(width: 10,),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: widget.selected=="light"?Colors.red:Colors.grey,shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),),
            child: Text("light"),
            onPressed: () {
              setState(() {
                if(widget.clickEnable)
                  widget.selected = "light";
              });}),
      ]);

  }
}