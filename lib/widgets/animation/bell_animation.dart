import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:lottie/lottie.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/animation/vertical_soft_navigation.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../provider/catalog_provider.dart';
import '../../provider/tab_bar_provider.dart';
import '../../screens/main_flow/notification_screen.dart';

class BellAnimation extends StatefulWidget {
  const BellAnimation({super.key});

  @override
  State<BellAnimation> createState() => _BellAnimationState();
}

class _BellAnimationState extends State<BellAnimation> with SingleTickerProviderStateMixin {

  late AnimationController _bellController;

  @override
  void initState() {
    final catalogProvider = Provider.of<CatalogProvider>(
      context,
      listen: false,
    );
    _bellController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
    catalogProvider.getNotificationCount(
      ((model) {
        if(model != null) {
          if(model.count != 0) {
            _bellController.forward();
          }
        }
      }),
    );
    super.initState();
  }

  @override
  void dispose() {
    _bellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return PunchingAnimation(
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
            padding: EdgeInsets.all(0.9.w),
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
            end: -0.3.w,
          ),
          child: Lottie.asset(
            Icons8.bell_material_filled,
            controller: _bellController,
            height: 3.2.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
