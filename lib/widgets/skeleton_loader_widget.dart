import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoaderWidget extends StatelessWidget {
  const SkeletonLoaderWidget({
    Key? key,
    required this.height,
    required this.width,
    this.borderRadius,
  }) : super(key: key);

  final double height, width;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromRGBO(241, 241, 241, 1),
      highlightColor: const Color.fromRGBO(255, 255, 255, 1),
      // highlightColor: Colors.black,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
      ),
    );
  }
}