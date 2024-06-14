import 'package:flutter/material.dart';
import '../helpers/constants.dart';
import 'package:sizer/sizer.dart';

class MemorialBookIconWidget extends StatelessWidget {
  const MemorialBookIconWidget({
    super.key,
    this.color,
    required this.title,
  });

  final Color? color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 2.2.h,
          ),
          Image.asset(
            ConstantsAssets.memorialBookLogoImage,
            height: 7.h,
            color: color ?? const Color.fromRGBO(23, 94, 217, 0.3),
          ),
          SizedBox(
            height: 1.2.h,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color ?? const Color.fromRGBO(23, 94, 217, 0.3),
              fontSize: 21.sp,
              fontFamily: ConstantsFonts.latoBlack,
              height: 0.8.sp,
            ),
          ),
          SizedBox(
            height: 2.2.h,
          ),
        ],
      ),
    );
  }
}
