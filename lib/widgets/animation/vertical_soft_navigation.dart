import 'package:flutter/cupertino.dart';

Route verticalSoftNavigation(Widget nextScreen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const Offset begin = Offset(0.0, 1.0);
      const Offset end = Offset.zero;
      const Cubic curve = Curves.ease;

      final Animatable<Offset> tween = Tween(
        begin: begin,
        end: end,
      ).chain(
        CurveTween(
          curve: curve,
        ),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
