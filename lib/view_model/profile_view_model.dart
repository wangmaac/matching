import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../model/hive_model/user.dart';

class ProfileViewModel extends ChangeNotifier {
  UserModel? currentUser;
  bool isLogin = false;
  bool isLongPress = false;

  setProfile(UserModel user) {
    currentUser = user;
    isLogin = true;
    notifyListeners();
  }

  setLongPress(bool b) {
    isLongPress = b;
    notifyListeners();
  }
}
