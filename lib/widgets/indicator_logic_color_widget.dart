import 'package:flutter/material.dart';

Widget indicatorLogicColorWidget(bool isActive, int pageIndex, BuildContext context) {
  return AnimatedContainer(
    duration: const Duration(
      milliseconds: 200,
    ),
    margin: const EdgeInsets.symmetric(
      horizontal: 6.0,
    ),
    height: 8.0,
    width: 8.0,
    decoration: BoxDecoration(
      color:
      isActive ? const Color.fromRGBO(23, 94, 217, 1) :
      const Color.fromRGBO(217, 217, 217, 1),
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
    ),
  );
}
