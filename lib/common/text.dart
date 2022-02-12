import 'package:cuppazee/common/common.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;

class Text extends StatelessWidget {
  const Text(this.child, {Key? key, this.style}) : super(key: key);

  final String child;
  final widgets.TextStyle? style;

  @override
  Widget build(BuildContext context) {
    if(Common.style == "fluent") {
      return fluent.Text(
        child,
        style: style,
      );
    }
    if(Common.style == "cupertino") {
      return cupertino.Text(
        child,
        style: style,
      );
    }
    if(Common.style == "macos") {
      return cupertino.Text(
        child,
        style: style,
      );
    }
    return material.Text(
      child,
      style: style,
    );
  }
}

class TextStyle {
  static get body {
    return const widgets.TextStyle(
      fontSize: 14,
      fontWeight: widgets.FontWeight.w400,
    );
  }
}