import 'package:cuppazee/common/common.dart';
import 'package:flutter/widgets.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;

class Button extends StatelessWidget {
  const Button({Key? key, required this.onPressed, required this.child, this.flat = false}) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final bool flat;

  @override
  Widget build(BuildContext context) {
    if(Common.style == "fluent") {
      if(flat) {
        return fluent.TextButton(
          child: child,
          onPressed: onPressed,
        );
      }
      return fluent.FilledButton(

        onPressed: onPressed,
        child: child,
      );
    }
    if(Common.style == "cupertino") {
      if(flat) {
        return cupertino.CupertinoButton(
          onPressed: onPressed,
          child: child,
        );
      }
      return cupertino.CupertinoButton.filled(
        onPressed: onPressed,
        child: child,
      );
    }
    if(Common.style == "macos") {
      return macos.PushButton(
        buttonSize: macos.ButtonSize.small,
        isSecondary: flat,
        onPressed: onPressed,
        child: child,
      );
    }
    if(flat) {
      return material.TextButton(
        onPressed: onPressed,
        child: child,
      );
    }
    return material.ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
