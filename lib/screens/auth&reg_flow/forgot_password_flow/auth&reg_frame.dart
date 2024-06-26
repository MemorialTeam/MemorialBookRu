import 'package:sizer/sizer.dart';
import '../../../helpers/constants.dart';
import '../../../widgets/memorial_book.dart';
import 'package:flutter/material.dart';

import '../../../widgets/platform_scroll_physics.dart';

class AuthRegFrame extends StatelessWidget {
  const AuthRegFrame({
    super.key,
    required this.title,
    required this.body,
    this.description,
    this.controller,
  });

  final String title;
  final String? description;

  final ScrollController? controller;

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      controller: controller,
      physics: platformScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 13.h,
          ),
          const MemorialBook(),
          SizedBox(
            height: 11.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.4.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 27.6.sp,
                    fontFamily: ConstantsFonts.latoSemiBold,
                    letterSpacing: -0.6,
                  ),
                ),
                description != null ?
                Padding(
                  padding: EdgeInsets.only(
                    top: 1.8.h,
                  ),
                  child: Text(
                    description ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: ConstantsFonts.latoRegular,
                      color: const Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                ) :
                const SizedBox(),
                body,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
