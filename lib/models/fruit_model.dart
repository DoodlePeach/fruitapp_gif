import 'package:flutter/foundation.dart';
import 'package:fruitapp/Database/DatabaseHelper.dart';

import '../Fruit.dart';
import '../MLKG.dart';

// This model holds data of the fruits of the current day
// and the operations associated with them.
class FruitModel extends ChangeNotifier {
  // Each fruit has a different list.
  List<Fruit> apple = [];
  List<Fruit> banana = [];
  List<Fruit> watermelon = [];
  List<Fruit> pear = [];

  // Load the fruits of a date.
  void refresh(DateTime currentDate) {
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

    // Wait for all of the fruits to be fetched and then notify the listeners.
    Future.wait([appleFuture, bananaFuture, pearFuture, watermelonFuture])
        .then((value) {
      notifyListeners();
    });
  }

  void clear() {
    apple.clear();
    banana.clear();
    watermelon.clear();
    pear.clear();
  }

  // Read-Update-Delete operations for Fruits
  Future addMLKG(MLKG mlkg) {
    return DatabaseQuery.db.newMLKG(mlkg).then((_) => notifyListeners());
  }

  Future updateMLKG(MLKG mlkg) {
    return DatabaseQuery.db
        .updateMLKG(mlkg, false)
        .then((_) => notifyListeners());
  }

  Future deleteMLKG(MLKG mlkg) {
    return DatabaseQuery.db.deleteMLKG(mlkg).then((value) => notifyListeners());
  }

  Future updateFruit(Fruit fruit) {
    return DatabaseQuery.db
        .updateFruit(fruit, false)
        .then((_) => notifyListeners());
  }

  Future deleteFruit(Fruit fruit) {
    return DatabaseQuery.db
        .deleteFruit(fruit)
        .then((value) => notifyListeners());
  }

  // Get the orignal reference to a fruit. Useful for binding it to widgets
  // when you are updating values.
  Fruit getReference(Fruit copy) {
    return apple.firstWhere((element) => (element.id == copy.id),
        orElse: () => watermelon.firstWhere(
            (element) => (element.id == copy.id),
            orElse: () => pear.firstWhere((element) => (element.id == copy.id),
                orElse: () =>
                    banana.firstWhere((element) => (element.id == copy.id)))));
  }
}
