import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class IndicatorProductGallery extends StatelessWidget {
  const IndicatorProductGallery({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.h,
      width: 2.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive == true ?
        const Color.fromRGBO(87, 167, 109, 1) :
        const Color.fromRGBO(87, 167, 109, 0.3),
      ),
    );
  }
}
