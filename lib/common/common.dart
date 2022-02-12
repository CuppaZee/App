import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:browser_detector/browser_detector.dart' hide Platform;

export './button.dart';
export './text.dart';
export './page.dart';
export './nav.dart';

class Common {
  static String? _style = 'fluent';

  static setStyle(String style) {
    _style = style;
  }

  static get style {
    if(fullStyle == "yaru") {
      return "material";
    }
    return fullStyle;
  }

  static get fullStyle {
    if (_style != null) {
      return _style;
    }
    if (kIsWeb) {
      var browserPlatform = BrowserDetector().platform;
      if (browserPlatform.isIOS) {
        return "cupertino";
      }
      if (browserPlatform.isAndroid) {
        return "material";
      }
      if (browserPlatform.isMacOS) {
        return "macos";
      }
      if (browserPlatform.isWindows) {
        return "fluent";
      }
      if (browserPlatform.isLinux) {
        return "yaru";
      }
      return "material";
    }
    if (Platform.isAndroid) {
      return "material";
    }
    if (Platform.isIOS) {
      return "cupertino";
    }
    if (Platform.isMacOS) {
      return "macos";
    }
    if (Platform.isWindows) {
      return "fluent";
    }
    if (Platform.isLinux) {
      return "yaru";
    }
    return "material";
  }
}