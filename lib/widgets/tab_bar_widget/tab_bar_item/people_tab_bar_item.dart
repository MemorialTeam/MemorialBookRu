import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';

BottomNavigationBarItem peopleTabBarItem(BuildContext context) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Image.asset(
        ConstantsAssets.peopleTabBarImage,
        height: 26,
        width: 37,
        color: Colors.black,
      ),
    ),
    activeIcon: Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Image.asset(
        ConstantsAssets.peopleTabBarImage,
        height: 26,
        width: 37,
        color: const Color.fromRGBO(23, 94, 217, 1),
      ),
    ),
    label: 'Люди',
  );
}