import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:sizer/sizer.dart';
import '../helpers/constants.dart';

class HomeFrameWidget extends StatelessWidget {
  const HomeFrameWidget({
    Key? key,
    required this.title,
    this.controller,
    required this.widget,
  }) : super(key: key);

  final String title;

  final ScrollController? controller;

  final Widget widget;

  void animateRight() {
    if(controller != null) {
      controller!.animateTo(
        controller!.position.pixels + 100.w,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
  void animateLeft() {
    if(controller != null) {
      controller!.animateTo(
        controller!.position.pixels - 100.w,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 1.6.h,
              left: 3.2.w,
              right: 3.2.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: ConstantsFonts.latoBold,
                  ),
                ),
                if(controller != null) Row(
                  children: [
                    PunchingAnimation(
                      child: Container(
                        height: 4.2.h,
                        width: 4.2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color.fromRGBO(229, 232, 235, 1),
                        ),
                        child: GestureDetector(
                          onTap: () => animateLeft(),
                          child: Center(
                            child: Icon(
                              Icons.arrow_left_outlined,
                              size: 26.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    PunchingAnimation(
                      child: Container(
                        height: 4.2.h,
                        width: 4.2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color.fromRGBO(229, 232, 235, 1),
                        ),
                        child: GestureDetector(
                          onTap: () => animateRight(),
                          child: Center(
                            child: Icon(
                              Icons.arrow_right_outlined,
                              size: 26.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          widget,
          SizedBox(
            height: 2.5.h,
          ),
        ],
      ),
    );
  }
}
