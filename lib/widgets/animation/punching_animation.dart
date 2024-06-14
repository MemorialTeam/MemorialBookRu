import 'package:flutter/material.dart';

class PunchingAnimation extends StatefulWidget {
  const PunchingAnimation({
    Key? key,
    required this.child,
    this.condition,
  }) : super(key: key);

  final Widget child;

  final bool? condition;

  @override
  State<PunchingAnimation> createState() => _PunchingAnimationState();
}

class _PunchingAnimationState extends State<PunchingAnimation> with TickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 75,
      ),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.condition == null) {
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
    } else if(widget.condition == true) {
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
    } else {
      return widget.child;
    }
  }
}
