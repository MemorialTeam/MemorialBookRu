import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/models/common/image_response_model.dart';
import 'package:memorial_book/widgets/full_screen_gallery.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../provider/tab_bar_provider.dart';

class GridGalleryWidget extends StatelessWidget {
  GridGalleryWidget({
    super.key,
    required this.images,
    this.title,
  });

  final List<ImageResponseModel> images;
  final String? title;

  final Color backgroundColor = Colors.black.withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context);
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
              return GestureDetector(
                onTap: () => Navigator.push(
                  tabBarProvider.mainContext,
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: backgroundColor,
                      pageBuilder: (BuildContext context, _, __) => FullScreenGallery(
                        title: title,
                        galleryModels: images,
                        initialIndex: index,
                      ),
                    // context: tabBarProvider.mainContext,
                  ),
                ),
                child: Hero(
                  tag: images[index].id.toString(),
                  child: CachedNetworkImage(
                    imageUrl: images[index].url ?? '',
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
              );
            },
          ),
          SizedBox(
            height: 0.2.h,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              tabBarProvider.mainContext,
              PageRouteBuilder(
                opaque: false,
                barrierColor: backgroundColor,
                pageBuilder: (BuildContext context, _, __) => FullScreenGallery(
                  title: title,
                  galleryModels: images,
                  initialIndex: 6,
                ),
                // context: tabBarProvider.mainContext,
              ),
            ),
            child: Hero(
              tag: images[6].id.toString(),
              child: CachedNetworkImage(
                imageUrl: images[6].url ?? '',
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
                return GestureDetector(
                  onTap: () => Navigator.push(
                    tabBarProvider.mainContext,
                    PageRouteBuilder(
                      opaque: false,
                      barrierColor: backgroundColor,
                      pageBuilder: (BuildContext context, _, __) => FullScreenGallery(
                        title: title,
                        galleryModels: images,
                        initialIndex: i,
                      ),
                    ),
                  ),
                  child: Hero(
                    tag: images[i].id.toString(),
                    child: CachedNetworkImage(
                      imageUrl: images[i].url ?? '',
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
          return GestureDetector(
            onTap: () => Navigator.push(
              tabBarProvider.mainContext,
              PageRouteBuilder(
                opaque: false,
                barrierColor: backgroundColor,
                pageBuilder: (BuildContext context, _, __) => FullScreenGallery(
                  title: title,
                  galleryModels: images,
                  initialIndex: index,
                ),
                // context: tabBarProvider.mainContext,
              ),
            ),
            child: Hero(
              tag: images[index].id.toString(),
              child: CachedNetworkImage(
                imageUrl: images[index].url ?? '',
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
            ),
          );
        },
      );
    }
  }
}
