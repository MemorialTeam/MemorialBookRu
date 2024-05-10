import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';

class RequiredText extends StatelessWidget {
  const RequiredText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: const Color.fromRGBO(32, 30, 31, 0.5),
          fontFamily: ConstantsFonts.latoRegular,
          fontSize: 9.5.sp,
        ),
        children: [
          TextSpan(
            text: '*',
            style: TextStyle(
              color: Colors.red,
              fontFamily: ConstantsFonts.latoRegular,
              fontSize: 9.5.sp,
            ),
          ),
        ],
      ),
    );
  }
}
