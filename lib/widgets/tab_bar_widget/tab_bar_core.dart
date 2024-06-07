import 'package:flutter/cupertino.dart';
import 'package:memorial_book/screens/main_flow/communities_screen.dart';
import 'package:memorial_book/screens/main_flow/home_screen.dart';
import 'package:memorial_book/screens/main_flow/people_screen.dart';
import 'package:memorial_book/screens/main_flow/places_screen.dart';
import 'package:memorial_book/screens/main_flow/profile_screen.dart';
import '../../helpers/constants.dart';

enum TabItem {
  people,
  places,
  home,
  communities,
  account,
  marketplace,
}

class TabBarCore extends StatelessWidget {
  TabBarCore({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
  }) : super(key: key);
  final GlobalKey<NavigatorState>? navigatorKey;
  TabItem tabItem = TabItem.home;

  Map<String, WidgetBuilder>? _routeBuilders(BuildContext context) {
    switch(tabItem) {
      case TabItem.home:
        return {
          ConstantsNavigatorKeys.root: (context) => const HomeScreen(),
        };
      case TabItem.people:
        return {
          ConstantsNavigatorKeys.root: (context) => PeopleScreen(),
        };
      case TabItem.places:
        return {
          ConstantsNavigatorKeys.root: (context) =>  PlacesScreen(),
        };
      case TabItem.communities:
        return {
          ConstantsNavigatorKeys.root: (context) => const CommunitiesScreen(),
        };
      case TabItem.account:
        return {
          ConstantsNavigatorKeys.root: (context) => const ProfileScreen(),
        };
      case TabItem.marketplace:
        return {
          ConstantsNavigatorKeys.root: (context) => const ProfileScreen(),
        };
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: ConstantsNavigatorKeys.root,
      onGenerateRoute: (routeSettings) {
        return CupertinoPageRoute(
          builder: (context) => routeBuilders![routeSettings.name!]!(context),
        );
      },
    );
  }
}