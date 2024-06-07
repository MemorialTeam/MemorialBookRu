import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:sizer/sizer.dart';

BottomNavigationBarItem peopleTabBarItem(BuildContext context) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: EdgeInsets.only(
        bottom: 0.6.h,
      ),
      child: Image.asset(
        ConstantsAssets.peopleTabBarImage,
        height: 3.h,
        color: Colors.black,
      ),
    ),
    activeIcon: Padding(
      padding: EdgeInsets.only(
        bottom: 0.5.h,
      ),
      child: Image.asset(
        ConstantsAssets.peopleTabBarImage,
        height: 3.h,
        color: const Color.fromRGBO(23, 94, 217, 1),
      ),
    ),
    label: 'Люди',
  );
}