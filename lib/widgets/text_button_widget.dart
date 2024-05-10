import 'package:flutter/material.dart';
import '../helpers/constants.dart';
import 'package:sizer/sizer.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    Key? key,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.isBigButton,
  }): super(key: key);

  final String text;

  final void Function() onTap;

  final TextStyle? textStyle;

  final bool? isBigButton;

  @override
  Widget build(BuildContext context) {
    if(isBigButton == false || isBigButton == null) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          minimumSize: const Size(0, 0),
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
        onPressed: onTap,
        child: Text(
          ' $text ',
          style: textStyle ?? TextStyle(
            fontSize: 11.sp,
            fontFamily: ConstantsFonts.latoRegular,
            color: const Color.fromRGBO(110, 133, 227, 1),
          ),
        ),
      );
    } else {
      return Container(
        height: 7.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15),
            child: Center(
              child: Text(
                text,
                style: textStyle ?? TextStyle(
                  fontSize: 11.sp,
                  fontFamily: ConstantsFonts.latoRegular,
                  color: const Color.fromRGBO(110, 133, 227, 1),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}