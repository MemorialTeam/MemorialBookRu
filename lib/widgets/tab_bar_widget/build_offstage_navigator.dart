import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../provider/tab_bar_provider.dart';

class BuildOffstageNavigator extends StatelessWidget {
  const BuildOffstageNavigator({
    Key? key,
    required this.tabItem,
  }) : super(key: key);
  final TabItem tabItem;

  @override
  Widget build(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return Offstage(
      offstage: tabBarProvider.currentTab != tabItem,
      child: TabBarCore(
        navigatorKey: tabBarProvider.navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}