import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../helpers/constants.dart';

BottomNavigationBarItem accountTabBarItem(BuildContext context) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding:  EdgeInsets.only(
        bottom: 0.5.h,
      ),
      child: Image.asset(
        ConstantsAssets.accountTabBarImage,
        height: 3.3.h,
        color: Colors.black,
      ),
    ),
    activeIcon: Padding(
      padding: EdgeInsets.only(
        bottom: 0.5.h,
      ),
      child: Image.asset(
        ConstantsAssets.accountTabBarImage,
        height: 3.3.h,
        color: const Color.fromRGBO(23, 94, 217, 1),
      ),
    ),
    label: 'Кабинет',
  );
}