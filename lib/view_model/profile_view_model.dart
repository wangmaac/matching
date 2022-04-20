import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../model/hive_model/user.dart';
import '../model/profile.dart';

class ProfileViewModel extends ChangeNotifier {
  UserModel? currentProfile;
  bool isLogin = false;

  setProfile(UserModel user) {
    currentProfile = user;
    isLogin = true;
    notifyListeners();
  }
}
