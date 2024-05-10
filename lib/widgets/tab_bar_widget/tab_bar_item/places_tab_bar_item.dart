import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';

BottomNavigationBarItem placesTabBarItem(BuildContext context) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Image.asset(
        ConstantsAssets.placesTabBarImage,
        height: 29,
        width: 32,
        color: Colors.black,
      ),
    ),
    activeIcon: Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Image.asset(
        ConstantsAssets.placesTabBarImage,
        height: 29,
        width: 32,
        color: const Color.fromRGBO(18, 175, 82, 1),
      ),
    ),
    label: 'Места',
  );
}