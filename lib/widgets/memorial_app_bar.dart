import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/screens/main_flow/notification_screen.dart';

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
                ),
              ),
            ) :
            null,
            trailing: automaticallyImplyBackTrailing == null ?
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.notifications_sharp,
                size: 24,
                color: Colors.black,
              ),
            ) :
            null,
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