import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/account_provider.dart';
import 'package:memorial_book/provider/catalog_provider.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/main_flow/notification_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../provider/auth_provider.dart';
import 'animation/punching_animation.dart';
import 'animation/vertical_soft_navigation.dart';

class MemorialAppBar extends StatelessWidget {
  MemorialAppBar({
    Key? key,
    required this.child,
    this.automaticallyImplyBackLeading,
    this.automaticallyImplyBackTrailing,
    this.colorIcon,
  }) : super(key: key);

  final Widget child;
  bool? automaticallyImplyBackLeading = false;
  bool? automaticallyImplyBackTrailing = false;
  Color? colorIcon;

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return CupertinoTheme(
      data: CupertinoThemeData(
        barBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        textTheme: CupertinoTextThemeData(
          primaryColor: Theme.of(context).primaryColorDark,
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
            border: Border.all(
              color: const Color.fromRGBO(255, 255, 255, 0.9),
            ),
            transitionBetweenRoutes: false,
            middle: Image.asset(
              ConstantsAssets.memorialBookLogoImage,
              height: 30.73,
              width: 30.73,
              color: colorIcon ?? const Color.fromRGBO(23, 94, 217, 1),
            ),
            trailing: authProvider.userRules == 'guest' ?
            null :
            automaticallyImplyBackTrailing == null ?
            PunchingAnimation(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => Navigator.push(
                  tabBarProvider.mainContext,
                  verticalSoftNavigation(
                    const NotificationScreen(),
                  ),
                ),
                child: badges.Badge(
                  showBadge: catalogProvider.notificationsCount != null,
                  badgeAnimation: const badges.BadgeAnimation.scale(
                    animationDuration: Duration(
                      milliseconds: 400,
                    ),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: const Color.fromRGBO(235, 87, 87, 1),
                    padding: EdgeInsets.all(0.8.w),
                  ),
                  badgeContent: Text(
                    '${catalogProvider.notificationsCount ?? 0}',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: ConstantsFonts.latoRegular,
                      fontSize: 6.5.sp,
                    ),
                  ),
                  position: badges.BadgePosition.topEnd(
                    top: 0.85.h,
                    end: -0.35.w,
                  ),
                  child: Image.asset(
                    catalogProvider.notificationsCount != null ?
                    ConstantsAssets.notificationIsNotEmpty :
                    ConstantsAssets.notificationIsEmpty,
                    height: 3.2.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ) :
            null,
            leading: automaticallyImplyBackLeading == true ?
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),
                child: Image.asset(
                  ConstantsAssets.leadingBackImage,
                  width: 20,
                  height: 16,
                  color: colorIcon ?? const Color.fromRGBO(23, 94, 217, 1),
                ),
              ),
            ) :
            null,
            // trailing: automaticallyImplyBackTrailing == null ?
            // BellAnimation() :
            // null,

          ),
          child: Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            child: child,
          ),
        ),
      ),
    );
  }
}