import 'package:sizer/sizer.dart';
import '../../helpers/enums.dart';
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

class TabBarWidgetState extends State<TabBarWidget> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    final tabBarProvider = Provider.of<TabBarProvider>(
      context,
      listen: false,
    );
    setState(() {
      tabBarProvider.tabController = TabController(
        length: 5,
        initialIndex: 2,
        vsync: this,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
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
          height: 8.2.h,
          child: Stack(
            children: [
              Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: SizedBox(
                  height: 8.3.h,
                  child: BottomNavigationWidget(
                    currentTab: tabBarProvider.currentTab,
                    onSelectTab: (tabItem) {
                      tabBarProvider.selectTab(tabItem);
                      if(authProvider.userRules == 'guest') {
                        if(tabItem == TabItem.account) {
                          authProvider.logoutGuest(context);
                          // _tabController.animateTo(tabItem);
                        }
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                right: 0.0,
                left: 0.0,
                child: IgnorePointer(
                  child: SizedBox(
                    height: 0.15.h,
                    child: TabBar(
                      enableFeedback: false,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: tabBarProvider.currentTab == TabItem.places ?
                        const Color.fromRGBO(18, 175, 82, 1) :
                        const Color.fromRGBO(23, 94, 217, 1),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: tabBarProvider.tabController,
                      tabs: const [
                        Tab(
                          child: SizedBox(),
                        ),
                        Tab(
                          child: SizedBox(),
                        ),
                        Tab(
                          child: SizedBox(),
                        ),
                        Tab(
                          child: SizedBox(),
                        ),
                        Tab(
                          child: SizedBox(),
                        ),
                      ],
                    ),
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
