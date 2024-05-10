import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:sizer/sizer.dart';

class TextFieldSearchWidget extends StatelessWidget {
  const TextFieldSearchWidget({
    Key? key,
    this.focusNode,
    this.onChanged,
    this.prefixIcon,
    required this.autofocus,
    required this.controller,
    this.textStyle,
    this.enabledBorder,
    this.backgroundColor,
    required this.hintText,
  }) : super(key: key);

  final FocusNode? focusNode;

  final void Function(String)? onChanged;

  final Widget? prefixIcon;

  final TextEditingController controller;

  final TextStyle? textStyle;

  final Color? backgroundColor;

  final bool autofocus;

  final InputBorder? enabledBorder;

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      controller: controller,
      focusNode: focusNode,
      enableSuggestions: false,
      autocorrect: false,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle ?? TextStyle(
          color: const Color.fromRGBO(79, 79, 79, 1),
          fontFamily: ConstantsFonts.latoRegular,
          fontSize: 11.5.sp,
        ),
        prefixIcon: prefixIcon ?? const SizedBox(),
        isDense: true,
        filled: true,
        fillColor: backgroundColor ?? const Color.fromRGBO(245, 247, 249, 1),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
        enabledBorder: enabledBorder ?? const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
      ),
    );
  }
}
