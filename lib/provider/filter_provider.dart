import 'package:flutter/cupertino.dart';

class FilterProvider extends ChangeNotifier {
  bool advancedSettings = false;

  void switcherOfState() {
    advancedSettings = !advancedSettings;
    notifyListeners();
  }
}