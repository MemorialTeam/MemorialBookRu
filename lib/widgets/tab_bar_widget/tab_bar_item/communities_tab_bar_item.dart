import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';

BottomNavigationBarItem communitiesTabBarItem(BuildContext context) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Image.asset(
        ConstantsAssets.communitiesTabBarImage,
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
        ConstantsAssets.communitiesTabBarImage,
        height: 29,
        width: 32,
        color: const Color.fromRGBO(23, 94, 217, 1),
      ),
    ),
    label: 'Сообщества',
  );
}