import 'package:cuppazee/common/nav.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:cuppazee/common/common.dart' show Common;

class BetterFluentPageRoute extends widgets.PageRoute {
  BetterFluentPageRoute({required this.builder, name})
      : super(settings: widgets.RouteSettings(name: name));

  final WidgetBuilder builder;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class PageRoute {
  static build(Widget Function(BuildContext) builder, String? name) {
    if (Common.style == 'fluent') {
      return BetterFluentPageRoute(
        builder: builder,
        name: name,
      );
    } else if (Common.style == 'cupertino') {
      return cupertino.CupertinoPageRoute(builder: builder);
    } else if (Common.style == 'macos') {
      return material.MaterialPageRoute(builder: builder);
    }
    return material.MaterialPageRoute(builder: builder);
  }
}

class Page extends StatefulWidget {
  const Page(
      {Key? key, required this.child, required this.title, this.navigator})
      : super(key: key);

  final Widget child;
  final String title;
  final GlobalKey<NavigatorState>? navigator;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    if (Common.style == 'fluent') {
      return fluent.NavigationView(
          appBar: fluent.NavigationAppBar(
            title: Text(widget.title),
          ),
          pane: fluent.NavigationPane(
            selected: index,
            onChanged: (i) => setState(() => index = i),
            displayMode: fluent.PaneDisplayMode.auto,
            items: [
              fluent.PaneItemHeader(header: const Text("sohcah")),
              fluent.PaneItem(
                icon: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(fluent.FluentIcons.calendar),
                ),
                title: const Text('Activity'),
              ),
              fluent.PaneItem(
                icon: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(fluent.FluentIcons.package),
                ),
                title: const Text('Inventory'),
              ),
              fluent.PaneItem(
                icon: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(fluent.FluentIcons.favorite_star)),
                title: const Text('Bouncers'),
              ),
              fluent.PaneItem(
                icon: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(fluent.FluentIcons.cube_shape),
                ),
                title: const Text('QRates'),
              ),
              fluent.PaneItemSeparator(),
              fluent.PaneItemHeader(header: const Text('Clans')),
              fluent.PaneItem(
                icon: fluent.Image.network(
                    "https://munzee.global.ssl.fastly.net/images/clan_logos/11h.png",
                    height: 24,
                    width: 24),
                title: Text((widget.child as Navigator).toStringDeep()),
              ),
            ],
          ),
          content: BlocBuilder<NavCubit, int>(
            builder: (context, state) {
              return Container(
                  color: fluent.FluentTheme.of(context).scaffoldBackgroundColor,
                  child: AnimatedSwitcher(
                    switchInCurve: fluent.FluentTheme.of(context)
                            .navigationPaneTheme
                            .animationCurve ??
                        Curves.linear,
                    duration: const Duration(milliseconds: 150),
                    layoutBuilder: (child, children) {
                      return SizedBox(child: child);
                    },
                    child: fluent.Container(
                      color: fluent.FluentTheme.of(context)
                          .scaffoldBackgroundColor,
                      key: ValueKey(state),
                      child: widget.child,
                    ),
                    transitionBuilder: (child, animation) {
                      return fluent.EntrancePageTransition(
                        child: child,
                        animation: animation,
                      );
                    },
                  ));
            },
          ));
    }
    if (Common.style == 'macos') {
      return macos.MacosWindow(
        sidebar: macos.Sidebar(
            minWidth: 200,
            topOffset: 0,
            bottom: Image.network("https://server.cuppazee.app/logo.png",
                height: 80),
            builder: (context, controller) {
              return macos.SidebarItems(
                currentIndex: 0,
                onChanged: (i) => {},
                // onChanged: (i) => setState(() => pageIndex = i),
                scrollController: controller,
                items: [
                  const macos.SidebarItem(
                    leading: macos.MacosIcon(
                      cupertino.CupertinoIcons.calendar,
                      color: cupertino.CupertinoColors.white,
                    ),
                    label: Text('Activity'),
                  ),
                  const macos.SidebarItem(
                    leading: macos.MacosIcon(
                      cupertino.CupertinoIcons.archivebox,
                    ),
                    label: Text('Inventory'),
                  ),
                  const macos.SidebarItem(
                    leading: macos.MacosIcon(cupertino.CupertinoIcons.star),
                    label: Text('Bouncers'),
                  ),
                  const macos.SidebarItem(
                    leading: macos.MacosIcon(cupertino.CupertinoIcons.cube_box),
                    label: Text('QRates'),
                  ),
                  macos.SidebarItem(
                    label: Text('Clans'),
                    disclosureItems: [
                      macos.SidebarItem(
                        leading: Image.network(
                            "https://munzee.global.ssl.fastly.net/images/clan_logos/11h.png",
                            height: 24,
                            width: 24),
                        // macos.MacosIcon(cupertino.CupertinoIcons.infinite),
                        label: Text('The Cup of Coffee Clan'),
                      ),
                      macos.SidebarItem(
                        leading: Image.network(
                            "https://munzee.global.ssl.fastly.net/images/clan_logos/${(457).toRadixString(36)}.png",
                            height: 24,
                            width: 24),
                        label: Text('The Cup of Tea Clan'),
                      ),
                      macos.SidebarItem(
                        leading: Image.network(
                            "https://munzee.global.ssl.fastly.net/images/clan_logos/${(1441).toRadixString(36)}.png",
                            height: 24,
                            width: 24),
                        label: Text('The Cup of Cocoa Clan'),
                      ),
                    ],
                  ),
                ],
              );
            }),
        child: macos.MacosScaffold(
          children: [
            macos.ContentArea(builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: widget.child,
              );
            }),
          ],
        ),
      );
    }
    if (Common.style == 'cupertino') {
      return cupertino.CupertinoPageScaffold(
        navigationBar: cupertino.CupertinoNavigationBar(
          middle: Text(widget.title),
        ),
        child: widget.child,
      );
    }

    var materialDrawer = material.Drawer(
      child: material.ListView(
        children: <material.Widget>[
          const material.DrawerHeader(
            child: Text('Drawer Header'),
            decoration: material.BoxDecoration(
              color: material.Colors.blue,
            ),
          ),
          material.ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          material.ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    return material.Scaffold(
        drawer: materialDrawer,
        appBar: material.AppBar(
          title: Text(widget.title),
        ),
        body: material.Row(children: [
          materialDrawer,
          Expanded(child: widget.child),
        ]));
  }
}
