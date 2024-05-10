import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import '../helpers/constants.dart';
import 'open_image_core.dart';

class ImageInPostWidget extends StatelessWidget {
  const ImageInPostWidget({
    Key? key,
    required this.isExpanded,
    required this.dataImages,
    required this.initialIndex,
  }) : super(key: key);

  final bool isExpanded;
  final List dataImages;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    if(isExpanded == true) {
      return Expanded(
        child: OpenImage(
          child: CachedNetworkImage(
            imageUrl: dataImages[initialIndex]['image'],
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                height: 117,
              );
            },
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return const SkeletonLoaderWidget(
                height: 117,
                width: double.infinity,
                borderRadius: 5,
              );
            },
            errorWidget: (context, error, widget) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage(ConstantsAssets.memorialBookLogoImage),
                  ),
                ),
                height: 117,
              );
            },
          ),
          disposeLevel: DisposeLevel.High,
          dataImage: dataImages,
          initialIndex: initialIndex,
          imageUrl: dataImages[initialIndex]['image'],
        ),
      );
    } else {
      return OpenImage(
        imageUrl: dataImages[initialIndex]['image'],
        child: CachedNetworkImage(
          imageUrl: dataImages[initialIndex]['image'],
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              height: 117,
            );
          },
          placeholder: (context, indicator) {
            return const SkeletonLoaderWidget(
              height: 117,
              width: double.infinity,
              borderRadius: 5,
            );
          },
        ),
        disposeLevel: DisposeLevel.High,
        dataImage: dataImages,
        initialIndex: 0,
      );
    }
  }
}
