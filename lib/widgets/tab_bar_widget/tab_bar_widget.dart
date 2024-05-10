import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_core.dart';
import '../../provider/auth_provider.dart';
import '../../provider/tab_bar_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_widget.dart';
import 'build_offstage_navigator.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TabBarWidgetState();
}

class TabBarWidgetState extends State<TabBarWidget> {

  @override
  Widget build(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: tabBarProvider.onWillPop,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: const Stack(
          children: [
            BuildOffstageNavigator(
              tabItem: TabItem.people,
            ),
            BuildOffstageNavigator(
              tabItem: TabItem.places,
            ),
            BuildOffstageNavigator(
              tabItem: TabItem.home,
            ),
            BuildOffstageNavigator(
              tabItem: TabItem.communities,
            ),
            BuildOffstageNavigator(
              tabItem: TabItem.account,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -5),
                blurRadius: 30,
                spreadRadius: 0,
                color: Color.fromRGBO(0, 0, 0, 0.1),
              ),
            ],
          ),
          height: 68,
          child: Stack(
            children: [
              Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: SizedBox(
                  height: 69,
                  child: BottomNavigationWidget(
                    currentTab: tabBarProvider.currentTab,
                    onSelectTab: (tabItem) {
                      tabBarProvider.selectTab(tabItem);
                      if(_authProvider.userRules == 'guest') {
                        if(tabItem == TabItem.account) {
                          _authProvider.logoutGuest(context);
                        }
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                right: 0.0,
                left: 0.0,
                top: 0.2,
                child: Row(
                  children: List.generate(
                    5,
                    ((index) {
                      if(index == tabBarProvider.tabItemIndex()) {
                        return Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 1.2,
                            color: tabBarProvider.tabItemIndex() != 1 ?
                            const Color.fromRGBO(23, 94, 217, 1) :
                            const Color.fromRGBO(18, 175, 82, 1),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 0.1,
                            color: Colors.transparent,
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
