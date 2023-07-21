import 'package:flutter/foundation.dart';

class MyPlatform {
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;
}
