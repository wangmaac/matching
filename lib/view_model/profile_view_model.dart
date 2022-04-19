import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../model/profile.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileModel? currentProfile;
  bool login = false;

  setProfile(ProfileModel user) {
    currentProfile = user;
    login = true;
  }
}
