import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../model/profile.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileModel? _currentProfile;

  setProfile(ProfileModel user, BuildContext context) {
    _currentProfile = user;
    context.go('/menu');
  }

  bool checkLogin() {
    if (_currentProfile == null) {
      return false;
    } else {
      return true;
    }
  }

  ProfileModel get profile => _currentProfile!;
}
