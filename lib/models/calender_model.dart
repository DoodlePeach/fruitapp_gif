import 'package:flutter/foundation.dart';

class CalenderModel extends ChangeNotifier {
  // This variable reflects if the calender is open.
  // It is helpful for "toggling" the calender across diffrent widgets.
  bool isCalenderOpen = false;
}
