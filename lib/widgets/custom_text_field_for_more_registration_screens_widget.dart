import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:sizer/sizer.dart';

class CustomTextFieldForMoreRegistrationScreensWidget extends StatelessWidget {
  const CustomTextFieldForMoreRegistrationScreensWidget({
    Key? key,
    required this.controller,
    this.alertText,
    required this.hintText,
    required this.obscureText,
    this.inputFormatters,
    this.prefixIcon,
    this.focusNode,
    this.showHide,
    this.maxLines,
    this.keyboardType,
    this.validate,
  }) : super(key: key);

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool obscureText;

  final String? alertText;
  final String hintText;

  final Widget? prefixIcon;
  final Widget? showHide;

  final int? maxLines;

  final TextInputType? keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: const Color.fromRGBO(23, 94, 217, 1),
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      style: TextStyle(
        fontSize: 12.sp,
        fontFamily: ConstantsFonts.latoRegular,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      minLines: 1,
      validator: validate,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 1.6.h,
          horizontal: 4.w,
        ),
        prefixIcon: prefixIcon,
        errorStyle: TextStyle(
          color: const Color.fromRGBO(250, 18, 46, 1),
          fontSize: 9.5.sp,
          fontFamily: ConstantsFonts.latoRegular,
        ),
        isDense: true,
        filled: true,
        hintText: hintText,
        fillColor: const Color.fromRGBO(250, 250, 250, 1),
        hintStyle: TextStyle(
          color: const Color.fromRGBO(189, 189, 189, 1),
          fontSize: 12.sp,
          fontFamily: ConstantsFonts.latoRegular
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color.fromRGBO(0, 0, 0, 0.15),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(13.0),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color.fromRGBO(250, 18, 46, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(13.0),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color.fromRGBO(250, 18, 46, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(13.0),
          ),
        ),
        suffixIcon: showHide,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(13.0),
          ),
        ),
      ),
    );
  }
}