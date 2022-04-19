import 'package:flutter/material.dart';

class DeviceViewModel with ChangeNotifier {
  late String _deviceKind;

  init() {
    MediaQueryData data =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    _deviceKind = data.size.shortestSide < 600 ? 'mobile' : 'pad';
  }

  String get deviceKind => _deviceKind;
}
