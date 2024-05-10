import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget indicatorGalleryPointWidget(bool isActive, int pageIndex, BuildContext context) {
  return AnimatedContainer(
    duration: const Duration(
      milliseconds: 200,
    ),
    margin: EdgeInsets.symmetric(
      horizontal: 2.5.w,
    ),
    height: 0.7.h,
    width: 0.7.h,
    decoration: BoxDecoration(
      color: isActive ?
      const Color.fromRGBO(255, 255, 255, 1) :
      const Color.fromRGBO(255, 255, 255, 0.4),
      shape: BoxShape.circle,
    ),
  );
}
