import 'MLKG.dart';

class Fruit {

  String name, type, comment,date,id;
  List<MLKG> mlkg;

  Fruit(
      {this.name, this.type, this.comment, this.date,this.id});

  // Conversion from json to Fruit object
  factory Fruit.fromMap(Map<String, dynamic> json) => new Fruit(
      name: json["text1"],
      type: json["text2"],
      comment: json["comment"],
      date: json["date"],
      id: json["id"]);

  // Mapping Fruit for database.
  Map<String, dynamic> toMap() => {
    "name": name,
    "type": type,
    "comment": comment,
    "date": date,
    if(id!=null)
      "id": id
  };
}
