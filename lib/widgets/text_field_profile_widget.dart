import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:sizer/sizer.dart';

class TextFieldProfileWidget extends StatelessWidget {
  const TextFieldProfileWidget({
    Key? key,
    this.focusNode,
    this.onChanged,
    this.hintText,
    this.maxLines,
    this.minLines,
    required this.controller,
    this.borderColor,
    this.inputFormatters,
    this.keyboardType,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  final int? maxLines;
  final int? minLines;

  final FocusNode? focusNode;

  final String? hintText;

  final void Function(String)? onChanged;

  final TextEditingController controller;

  final Color? borderColor;

  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? keyboardType;

  final Widget? suffixIcon;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      enableSuggestions: false,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      autocorrect: false,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 12.sp,
        fontFamily: ConstantsFonts.latoRegular,
      ),
      validator: validator,
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(250, 18, 46, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(250, 18, 46, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        errorStyle: TextStyle(
          color: const Color.fromRGBO(250, 18, 46, 1),
          fontFamily: ConstantsFonts.latoRegular,
          fontSize: 8.sp,
        ),
        suffixIcon: controller.text.isNotEmpty ?
        suffixIcon :
        null,
        hintStyle: TextStyle(
          color: const Color.fromRGBO(32, 30, 31, 0.5),
          fontSize: 12.sp,
          fontFamily: ConstantsFonts.latoRegular,
        ),
        isDense: true,
        filled: true,
        hintText: hintText,
        fillColor: const Color.fromRGBO(245, 247, 249, 1),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? Colors.black,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? const Color.fromRGBO(205, 209, 214, 1),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 1.1.h,
          horizontal: 3.2.w,
        ),
      ),
    );
  }
}
