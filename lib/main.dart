import 'dart:io';
import 'package:browser_detector/browser_detector.dart' hide Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:cuppazee/common/common.dart' as common;
import 'package:cuppazee/common/common.dart' show Common;

import 'package:yaru/yaru.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
void main() {
  runApp(BlocProvider(
    create: (_) => common.NavCubit(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var title = "CuppaZee";
    if (!kIsWeb) {
      if (Platform.isMacOS) {
        title = "CuppaZee for Mac";
      }
      if (Platform.isWindows) {
        title = "CuppaZee for Windows";
      }
      if (Platform.isLinux) {
        title = "CuppaZee for Linux";
      }
      if (Platform.isAndroid) {
        title = "CuppaZee for Android";
      }
      if (Platform.isIOS) {
        title = "CuppaZee for iOS";
      }
    }
    if (Common.style == "fluent") {
      return fluent.FluentApp(
        title: 'CuppaZee',
        theme: fluent.ThemeData(
          brightness: fluent.Brightness.light,
          visualDensity: fluent.VisualDensity.standard,
        ),
        color: fluent.Colors.white,
        home: MyHomePage(title: title),
        builder: (context, child) {
          return common.Page(child: child ?? Container(), title: 'CuppaZee', navigator: _navigator);
        },
        navigatorKey: _navigator,
        navigatorObservers: [
          routeObserver,
        ],
      );
    }
    if (Common.style == "cupertino") {
      return cupertino.CupertinoApp(
        title: 'CuppaZee',
        theme: const cupertino.CupertinoThemeData(
          brightness: cupertino.Brightness.light,
        ),
        home: MyHomePage(title: title),
      );
    }
    if (Common.style == "macos") {
      return macos.MacosApp(
        title: 'CuppaZee',
        themeMode: material.ThemeMode.dark,
        home: MyHomePage(title: title),
      );
    }
    return material.MaterialApp(
      title: 'Flutter Demo',
      darkTheme: Common.fullStyle == "yaru"
          ? yaruDark
          : material.ThemeData(
              primaryColor: material.Colors.lightGreenAccent,
              brightness: material.Brightness.dark,
            ),
      themeMode: material.ThemeMode.dark,
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var main = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        common.Text(
          'You have pushed the button this many times:',
          style: common.TextStyle.body,
        ),
        common.Text(
          '$_counter',
        ),
        Text(
          "This is really cool on a ${size.width > 800 ? "big" : "small"} device!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: fluent.Colors.red,
          ),
        ),
        if (kIsWeb)
          common.Text(
            'Platform: ${BrowserDetector().platform.isAndroid ? 'android' : (BrowserDetector().platform.isIOS ? 'ios' : (BrowserDetector().platform.isMacOS ? 'macos' : (BrowserDetector().platform.isWindows ? 'windows' : (BrowserDetector().platform.isLinux ? 'linux' : 'unknown'))))}',
          ),
        if (!kIsWeb)
          common.Text(
            'Platform: ${Platform.operatingSystem}',
          ),
        common.Text('Style: ${Common.style}'),
        common.Button(
            child: Text('Increment Counter'), onPressed: _incrementCounter),
        common.Button(
            child: Text('Something else'),
            onPressed: () => {
              common.Nav.push(
                    context,
                    common.PageRoute.build((context) => const MyOtherPage(
                          title: 'w',
                        ), "/other"),
                  )
                }),
        common.Button(
            flat: true,
            child: Text('Material'),
            onPressed: () => {Common.setStyle('materal')}),
      ],
    );
    return main;
  }
}

class MyOtherPage extends StatefulWidget {
  const MyOtherPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyOtherPage> createState() => _MyOtherPageState();
}

class _MyOtherPageState extends State<MyOtherPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var main = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "This is kinda cool on a ${size.width > 800 ? "big" : "small"} device!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: fluent.Colors.red,
          ),
        ),
        if (kIsWeb)
          common.Text(
            'Platform: ${BrowserDetector().platform.isAndroid ? 'android' : (BrowserDetector().platform.isIOS ? 'ios' : (BrowserDetector().platform.isMacOS ? 'macos' : (BrowserDetector().platform.isWindows ? 'windows' : (BrowserDetector().platform.isLinux ? 'linux' : 'unknown'))))}',
          ),
        common.Text(
          'You have pushed the button this many times:',
          style: common.TextStyle.body,
        ),
        common.Text(
          '$_counter',
        ),
        if (!kIsWeb)
          common.Text(
            'Platform: ${Platform.operatingSystem}',
          ),
        common.Text('Style: ${Common.style}'),
        common.Button(
            child: Text('Increment Counter'), onPressed: _incrementCounter),
        common.Button(
            child: Text('Something else'),
            onPressed: () => {
              common.Nav.push(
                    context,
                    common.PageRoute.build(
                        (context) => const MyHomePage(title: 'Idk'), "main"),
                  )
                }),
        common.Button(
            flat: true,
            child: Text('Material'),
            onPressed: () => {Common.setStyle('materal')}),
      ],
    );
    return main;
  }
}
