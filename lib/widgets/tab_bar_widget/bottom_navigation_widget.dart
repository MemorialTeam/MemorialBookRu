import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_core.dart';
import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_item/account_tab_bar_item.dart';
import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_item/communities_tab_bar_item.dart';
import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_item/home_tab_bar_item.dart';
import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_item/people_tab_bar_item.dart';
import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_item/places_tab_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/constants.dart';
import 'package:sizer/sizer.dart';

import '../../provider/tab_bar_provider.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({Key? key,
    required this.currentTab,
    required this.onSelectTab,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(
            fontSize: 8.sp,
            color: const Color.fromRGBO(23, 94, 217, 1),
            fontFamily: ConstantsFonts.latoRegular,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 8.sp,
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontFamily: ConstantsFonts.latoRegular,
          ),
          selectedItemColor: currentTab.index != 1 ?
          const Color.fromRGBO(23, 94, 217, 1) :
          const Color.fromRGBO(18, 175, 82, 1),
          unselectedItemColor: Colors.black,
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        type: BottomNavigationBarType.fixed,
        items: [
          peopleTabBarItem(context),
          placesTabBarItem(context),
          homeTabBarItem(context),
          communitiesTabBarItem(context),
          accountTabBarItem(context),
        ],
        selectedLabelStyle: TextStyle(
          fontSize: 8.sp,
          fontFamily: ConstantsFonts.latoRegular,
          color: const Color.fromRGBO(32, 30, 31, 1),
        ),
        onTap: (index) {
          tabBarProvider.tabController.animateTo(index);
          onSelectTab(
            TabItem.values[index],
          );
        },
        currentIndex: currentTab.index,
      ),
    );
  }
}