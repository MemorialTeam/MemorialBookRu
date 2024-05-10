import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:sizer/sizer.dart';

class HomeFrameSkeletonWidget extends StatelessWidget {
  const HomeFrameSkeletonWidget({
    Key? key,
    required this.widget,
    required this.width,
  }) : super(key: key);

  final Widget widget;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 255, 255, 1),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonLoaderWidget(
                  height: 3.2.h,
                  width: width.w,
                  borderRadius: 14,
                ),
                Row(
                  children: [
                    SkeletonLoaderWidget(
                      height: 4.2.h,
                      width: 4.2.h,
                      borderRadius: 7,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    SkeletonLoaderWidget(
                      height: 4.2.h,
                      width: 4.2.h,
                      borderRadius: 7,
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
            height: 1.8.h,
          ),
        ],
      ),
    );
  }
}
