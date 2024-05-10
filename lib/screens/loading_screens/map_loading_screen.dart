import '../../widgets/skeleton_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MapLoadingScreen extends StatelessWidget {
  const MapLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
              right: 1.6.h,
            ),
            child: SkeletonLoaderWidget(
              height: 6.2.h,
              width: 6.2.h,
              borderRadius: 1000,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 9.2.h,
            left: 16,
          ),
          child: SkeletonLoaderWidget(
            height: 5.h,
            width: 36.w,
            borderRadius: 30,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Shimmer.fromColors(
            baseColor: const Color.fromRGBO(241, 241, 241, 1),
            highlightColor: const Color.fromRGBO(255, 255, 255, 1),
            child: Container(
              height: 24.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
        ),
        SkeletonLoaderWidget(
          height: 7.6.h,
          width: double.infinity,
          borderRadius: 0,
        ),
      ],
    );
  }
}
