import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:matching/model/hive_model/user.dart';

class JigsawViewModel with ChangeNotifier {
  List<bool> answerPieceList = [];
  bool complete = false;
  UserModel? user;

  //todo init
  setUser(UserModel who) {
    user = who;
  }

  //todo init
  initJigsaw(int pieceCount) {
    complete = false;
    answerPieceList = List.filled(pieceCount, false);
  }

  updatePiece(BuildContext context, int index, String s) {
    answerPieceList[index] = true;
    if (!answerPieceList.contains(false)) {
      setComplete();
      hiveUpdate(context, s);
    }
  }

  setComplete() {
    complete = true;
  }

  hiveUpdate(
    BuildContext context,
    String s,
  ) {
    if (!user!.jigsawAnswerList!.contains(s)) {
      user!.jigsawAnswerList!.add(s);
      Hive.box<UserModel>('user').put(user!.name, user!);
    }
    notifyListeners();
  }
}
