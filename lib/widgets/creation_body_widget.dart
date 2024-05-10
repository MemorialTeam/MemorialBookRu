import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreationBodyWidget extends StatelessWidget {
  const CreationBodyWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2.8.h,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: child,
    );
  }
}
