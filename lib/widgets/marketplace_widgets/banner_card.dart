import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:sizer/sizer.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({
    Key? key,
    required this.networkImage,
  }) : super(key: key);

  final String networkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14.5.h,
      margin: EdgeInsets.symmetric(
        horizontal: 1.w,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(networkImage),
          fit: BoxFit.fill,
        ),
      ),
    );
    // return CachedNetworkImage(
    //   height: 19.5.h,
    //   imageUrl: networkImage,
    //   progressIndicatorBuilder: (context, _, progress) {
    //     return SkeletonLoaderWidget(
    //       height: 19.5.h,
    //       width: double.infinity,
    //     );
    //   },
    //   imageBuilder: (context, imageProvider) {
    //     return Container(
    //       height: 19.5.h,
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //         image: DecorationImage(
    //           image: imageProvider,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}