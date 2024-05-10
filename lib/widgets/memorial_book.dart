import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../helpers/constants.dart';

class MemorialBook extends StatelessWidget {
  const MemorialBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          ConstantsAssets.memorialBookLogoImage,
          height: 6.h,
          color: const Color.fromRGBO(23, 94, 217, 1),
        ),
        SizedBox(
          height: 3.4.h,
        ),
        Image.asset(
          ConstantsAssets.memorialBookTextImage,
          height: 2.h,
        ),
      ],
    );
  }
}
