import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import '../helpers/constants.dart';
import 'package:sizer/sizer.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.text,
    this.condition,
    this.activeColor = const Color.fromRGBO(23, 94, 217, 1),
    this.inactiveColor = const Color.fromRGBO(23, 94, 217, 0.5),
    required this.onTap,
    this.margin,
    this.padding,
    this.border,
    this.textStyle,
    this.child,
  });

  final String? text;

  final bool? condition;

  final Color activeColor;
  final Color inactiveColor;

  final void Function() onTap;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;

  final TextStyle? textStyle;

  final Widget? child;

  Color buttonColor() {
    if(condition != null) {
      if(condition == true) {
        return activeColor;
      } else {
        return inactiveColor;
      }
    } else {
      return activeColor;
    }
  }

  void onTapEvent() {
    if(condition != null) {
      if(condition == true) {
        return onTap();
      } else {
        return;
      }
    } else {
      return onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PunchingAnimation(
      condition: condition,
      child: Container(
        width: padding == null ?
        double.infinity :
        null,
        margin: margin,
        decoration: BoxDecoration(
          color: buttonColor(),
          borderRadius: BorderRadius.circular(10),
          border: border,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTapEvent,
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(
                vertical: 1.6.h,
              ),
              child: child != null ?
              child! :
              Center(
                child: Text(
                  text ?? '',
                  style: textStyle ?? TextStyle(
                    color: Colors.white,
                    fontFamily: ConstantsFonts.latoRegular,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
