import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../helpers/constants.dart';

class ObscureWidget extends StatelessWidget {
  const ObscureWidget({
    super.key,
    required this.onTap,
    required this.state,
    required this.controller,
  });

  final void Function() onTap;

  final bool state;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(1.5.h),
        child: Image.asset(
          state == true ?
          ConstantsAssets.eyeClosedImage :
          ConstantsAssets.eyeOpenedImage,
          height: 2.8.h,
          color: controller.text.isNotEmpty ?
          const Color.fromRGBO(32, 30, 31, 1) :
          null,
        ),
      ),
    );
  }
}
