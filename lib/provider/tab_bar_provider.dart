import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:flutter/material.dart';
import '../helpers/constants.dart';
import '../helpers/enums.dart';

class TabBarProvider extends ChangeNotifier {
  TabItem currentTab = TabItem.home;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = ConstantsNavigatorKeys.navigatorKeys;

  late BuildContext mainContext;
  PageController galleryController = PageController();

  late TabController tabController;

  int tabItemIndex() {
    switch(currentTab) {
      case TabItem.people:
        return 0;
      case TabItem.places:
        return 1;
      case TabItem.home:
        return 2;
      case TabItem.communities:
        return 3;
      case TabItem.account:
        return 4;
    }
  }

  void setContext(BuildContext context) {
    mainContext = context;
  }

  void tabBarDispose() {
    currentTab = TabItem.home;
  }

  void selectTab(TabItem tabItem) {
    if (tabItem == currentTab) {
      navigatorKeys[tabItem]!.currentState!.popUntil((Route<dynamic> route) => route.isFirst);
    } else {
      currentTab = tabItem;
      notifyListeners();
    }
  }
  Future<bool> onWillPop() async {
    final isFirstRouteInCurrentTab =
    !await navigatorKeys[currentTab]!.currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      if (currentTab != TabItem.home) {
        selectTab(TabItem.home);
        return false;
      }
    }
    SVProgressHUD.dismiss();
    return isFirstRouteInCurrentTab;
  }
}