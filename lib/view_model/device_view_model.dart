import 'package:flutter/material.dart';

enum DeviceKind { Pad, Mobile }

class DeviceViewModel with ChangeNotifier {
  late DeviceKind _deviceKind;

  init() {
    MediaQueryData data =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    _deviceKind =
        data.size.shortestSide < 600 ? DeviceKind.Mobile : DeviceKind.Pad;
  }

  DeviceKind get deviceKind => _deviceKind;
}
