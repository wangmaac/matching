import 'package:flutter/material.dart';

class JigsawViewModel extends ChangeNotifier {
  bool complete = false;

  initViewModel() {
    complete = false;
  }

  setComplete() {
    complete = true;
    notifyListeners();
  }
}
