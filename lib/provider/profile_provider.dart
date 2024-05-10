import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  bool switchStateProfile = false;
  TextEditingController fullNameController = TextEditingController();

  void switcherOfState() {
    switchStateProfile = !switchStateProfile;
    notifyListeners();
  }
}