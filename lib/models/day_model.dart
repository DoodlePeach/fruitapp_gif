import 'package:flutter/foundation.dart';
import 'package:fruitapp/Database/DatabaseHelper.dart';

import '../Fruit.dart';

class DayModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  List<Fruit> fruits = [];

  final int startingIndex = (.161251195141521521142025 * 1e6).round();
  int currentIndex = (.161251195141521521142025 * 1e6).round();

  void refresh() {
    DatabaseQuery.db
        .getAllFruits(
            "${currentDate.day}/${currentDate.month}/${currentDate.year}")
        .then((List<Fruit> fetched) => fruits = fetched)
        .then((value) => notifyListeners());
  }

  void pageChanged(int newIndex) {
    if (newIndex - currentIndex > 0)
      next();
    else if (newIndex - currentIndex < 0) previous();
  }

  void next() {
    currentDate = currentDate.add(new Duration(days: 1));
    currentIndex++;
    refresh();
  }

  void previous() {
    currentDate = currentDate.subtract(new Duration(days: 1));
    currentIndex--;
    refresh();
  }
}
