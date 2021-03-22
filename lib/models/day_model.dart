import 'package:flutter/foundation.dart';

class DayModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();

  final int startingIndex = (.161251195141521521142025 * 1e6).round();
  int currentIndex = (.161251195141521521142025 * 1e6).round();

  void pageChanged(int newIndex) {
    print(newIndex);

    if (newIndex - currentIndex > 0)
      next();
    else if (newIndex - currentIndex < 0) previous();

    notifyListeners();
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
  }

  void previous() {
    currentDate = currentDate.subtract(new Duration(days: 1));
    currentIndex--;
  }
}
