import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:sizer/sizer.dart';
import 'open_image_core.dart';

class GridGalleryWidget extends StatelessWidget {
  const GridGalleryWidget({
    super.key,
    required this.images,
  });

  final List images;

  @override
  Widget build(BuildContext context) {
    if(images.length > 6) {
      return Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0.2.h,
              crossAxisSpacing: 0.2.h,
            ),
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return OpenImage(
                initialIndex: index,
                disposeLevel: DisposeLevel.High,
                dataImage: images,
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  progressIndicatorBuilder: (context, url, downloadProgress) => SkeletonLoaderWidget(
                    height: 28.h,
                    width: double.infinity,
                    borderRadius: 0,
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Text(
                      'ERROR',
                      style: TextStyle(
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 28.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: 0.2.h,
          ),
          OpenImage(
            initialIndex: 6,
            disposeLevel: DisposeLevel.High,
            dataImage: images,
            child: CachedNetworkImage(
              imageUrl: images[6],
              progressIndicatorBuilder: (context, url, downloadProgress) => SkeletonLoaderWidget(
                height: 28.h,
                width: double.infinity,
                borderRadius: 0,
              ),
              errorWidget: (context, url, error) => Center(
                child: Text(
                  'ERROR',
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
              ),
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 28.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 0.2.h,
          ),
          if(images.length > 7)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0.2.h,
                crossAxisSpacing: 0.2.h,
              ),
              itemCount: images.length - 7,
              itemBuilder: (BuildContext context, int index) {
                int i = index + 7;
                return OpenImage(
                  initialIndex: i,
                  disposeLevel: DisposeLevel.High,
                  dataImage: images,
                  child: CachedNetworkImage(
                    imageUrl: images[i],
                    progressIndicatorBuilder: (context, url, downloadProgress) => SkeletonLoaderWidget(
                      height: 28.h,
                      width: double.infinity,
                      borderRadius: 0,
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text(
                        'ERROR',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 28.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
        ],
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 0.2.h,
          crossAxisSpacing: 0.2.h,
        ),
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return OpenImage(
            initialIndex: index,
            disposeLevel: DisposeLevel.High,
            dataImage: images,
            child: CachedNetworkImage(
              imageUrl: images[index],
              progressIndicatorBuilder: (context, url, downloadProgress) => SkeletonLoaderWidget(
                height: 28.h,
                width: double.infinity,
                borderRadius: 0,
              ),
              errorWidget: (context, url, error) => Center(
                child: Text(
                  'ERROR',
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
              ),
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 28.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }
}
