import 'package:flutter/foundation.dart';
import 'package:fruitapp/Database/DatabaseHelper.dart';

import '../Fruit.dart';

class DayModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();

  List<Fruit> apple = [];
  List<Fruit> banana = [];
  List<Fruit> watermelon = [];
  List<Fruit> pear = [];

  final int startingIndex = (.161251195141521521142025 * 1e6).round();
  int currentIndex = (.161251195141521521142025 * 1e6).round();

  void refresh() {

    Future appleFuture = DatabaseQuery.db
        .getAllFruits("apple",
            "${currentDate.day}/${currentDate.month}/${currentDate.year}")
        .then((List<Fruit> fetched) {
      apple = fetched;
    });

    Future bananaFuture = DatabaseQuery.db
        .getAllFruits("banana",
            "${currentDate.day}/${currentDate.month}/${currentDate.year}")
        .then((List<Fruit> fetched) {
      banana = fetched;
    });

    Future pearFuture = DatabaseQuery.db
        .getAllFruits("watermelon",
            "${currentDate.day}/${currentDate.month}/${currentDate.year}")
        .then((List<Fruit> fetched) {
      watermelon = fetched;
    });

    Future watermelonFuture = DatabaseQuery.db
        .getAllFruits("pear",
            "${currentDate.day}/${currentDate.month}/${currentDate.year}")
        .then((List<Fruit> fetched) {
      pear = fetched;
    });

    Future.wait([appleFuture, bananaFuture, pearFuture, watermelonFuture])
        .then((value) {
      notifyListeners();
    });
  }

  void pageChanged(int newIndex) {
    if (newIndex - currentIndex > 0)
      next();
    else if (newIndex - currentIndex < 0) previous();

    refresh();
  }

  void setNewDate(DateTime newDate) {
    final int difference = currentDate.difference(newDate).inDays;

    currentIndex -= difference;
    currentDate = newDate;

    notifyListeners();
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
