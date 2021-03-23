import 'package:flutter/foundation.dart';
import 'package:fruitapp/Database/DatabaseHelper.dart';

import '../Fruit.dart';
import '../MLKG.dart';

class FruitModel extends ChangeNotifier {
  List<Fruit> apple = [];
  List<Fruit> banana = [];
  List<Fruit> watermelon = [];
  List<Fruit> pear = [];

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

  Fruit getReference(Fruit copy) {
    return apple.firstWhere((element) => (element.id == copy.id),
        orElse: () => watermelon.firstWhere(
            (element) => (element.id == copy.id),
            orElse: () => pear.firstWhere((element) => (element.id == copy.id),
                orElse: () =>
                    banana.firstWhere((element) => (element.id == copy.id)))));
  }
}
