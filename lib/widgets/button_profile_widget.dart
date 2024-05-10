import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ButtonProfileWidget extends StatelessWidget {
  const ButtonProfileWidget({
    Key? key,
    required this.borderColor,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final Color borderColor;
  final void Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor,
        ),
        color: const Color.fromRGBO(245, 247, 249, 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(1.2.h),
            child: child,
          ),
        ),
      ),
    );
  }
}
