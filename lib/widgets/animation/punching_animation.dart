import 'package:flutter/material.dart';

class PunchingAnimation extends StatefulWidget {
  const PunchingAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<PunchingAnimation> createState() => _PunchingAnimationState();
}

class _PunchingAnimationState extends State<PunchingAnimation> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(
      milliseconds: 75,
    ),
    vsync: this,
  );

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(
        begin: 1.0,
        end: 0.94,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.ease,
        ),
      ),
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) =>_controller.forward(),
        onPointerUp: (event) => _controller.reverse(),
        child: widget.child,
      ),
    );
  }
}
