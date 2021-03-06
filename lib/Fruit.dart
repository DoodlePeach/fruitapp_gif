import 'MLKG.dart';

class Fruit {
  String name, type, comment, date, gif;
  int id;
  String time, categorySize;
  List<MLKG> mlkg = [];

  Fruit(this.name, this.type, this.comment, this.date, this.id, this.time,
      this.categorySize, this.gif);

  // Conversion from json to Fruit object
  factory Fruit.fromMap(Map<String, dynamic> json) => new Fruit(
      json["name"],
      json["type"],
      json["comment"],
      json["date"],
      json["id"],
      json["time"],
      json["categorySize"],
      json["gifPath"]);
  // Mapping Fruit for database.
  Map<String, dynamic> toMap() => {
        "name": name,
        "type": type,
        "comment": comment,
        "date": date,
        "gifPath": gif,
        if (time == null) "time": "00:00:00" else "time": time,
        if (categorySize != null)
          "categorySize": categorySize
        else
          "categorySize": "None",
        if (id != null) "id": id,
      };
}
