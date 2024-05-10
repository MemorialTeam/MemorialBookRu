import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/gradient_text.dart';
import 'package:sizer/sizer.dart';

class QuickLinkWidget extends StatelessWidget {
  const QuickLinkWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.isActive,
    this.onTap,
    this.margin,
  }) : super(key: key);

  final bool isActive;

  final String title;

  final Widget image;

  final EdgeInsetsGeometry? margin;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PunchingAnimation(
        child: GestureDetector(
          onTap: isActive == true ?
          onTap :
          null,
          child: Container(
            height: 12.5.h,
            width: double.infinity,
            margin: margin,
            decoration: BoxDecoration(
              color: isActive == true ?
              const Color.fromRGBO(255, 255, 255, 1) :
              const Color.fromRGBO(255, 255, 255, 0.3),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(5, 5), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 21,
                    vertical: 15,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      image,
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontFamily: ConstantsFonts.latoRegular,
                          color: isActive == true ?
                          const Color.fromRGBO(32, 30, 31, 1) :
                          const Color.fromRGBO(32, 30, 31, 0.3),
                        ),
                      ),
                    ],
                  ),
                ),
                isActive == true ?
                const SizedBox() :
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: GradientText(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(23, 94, 217, 1),
                          Color.fromRGBO(13, 153, 255, 1),
                        ],
                      ),
                      text: 'Coming soon',
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontFamily: ConstantsFonts.latoRegular,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}