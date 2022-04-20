import 'package:flutter/material.dart';

class JigsawViewModel extends ChangeNotifier {
  List<String> answerList = [];

  bool complete = false;

  addAnswerList(String value) {
    if (!answerList.contains(value)) {
      answerList.add(value);
    }
  }

  initViewModel() {
    complete = false;
  }

  setComplete(String value) {
    complete = true;
    if (value.substring(0, 1) == 'u') {
      addAnswerList(value.toUpperCase().substring(1, 2));
    } else {
      addAnswerList(value.toLowerCase().substring(1, 2));
    }
    print(answerList.toString());
    notifyListeners();
  }
}
