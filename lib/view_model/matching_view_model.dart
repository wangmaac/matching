import 'package:flutter/material.dart';

class MatchingViewModel extends ChangeNotifier {
  List<String> _answerList = [];
  bool complete = false;

  void addAnswerList(String answer) {
    _answerList.add(answer);
    notifyListeners();
  }

  List<String> get getList => _answerList;

  void resetAnswerList() {
    complete = false;
    _answerList.clear();
  }

  void completeMatching() {
    if (_answerList.length == 4) {
      complete = true;
    } else {
      complete = false;
    }
    notifyListeners();
  }
}
