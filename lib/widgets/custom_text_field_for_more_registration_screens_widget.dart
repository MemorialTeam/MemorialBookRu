import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        style: TextStyle(
          fontSize: 12.sp,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        minLines: 1,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          isDense: true,
          filled: true,
          hintText: hintText,
          fillColor: const Color.fromRGBO(250, 250, 250, 1),
          hintStyle: TextStyle(
            color: const Color.fromRGBO(158, 158, 158, 1),
            fontSize: 12.sp,
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
      ),
    );
  }
}