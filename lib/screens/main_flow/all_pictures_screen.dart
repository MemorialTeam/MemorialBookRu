import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/platform_scroll_physics.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/constants.dart';
import '../../widgets/full_screen_gallery.dart';
import '../../widgets/skeleton_loader_widget.dart';

class AllPicturesScreen extends StatelessWidget {
  const AllPicturesScreen({
    Key? key,
    required this.imagesList,
    required this.galleryTitle,
  }) : super(key: key);

  final List imagesList;
  final String galleryTitle;

  @override
  Widget build(BuildContext context) {
    return UnScopeScaffold(
      floatingActionButton: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 6.4.h,
          width: 6.4.h,
          margin: EdgeInsets.symmetric(
            vertical: 7.6.h,
          ),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            shape: BoxShape.circle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(50),
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 2.4.h,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.separated(
        physics: platformScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                barrierColor: Colors.black.withOpacity(0.4),
                pageBuilder: (BuildContext context, _, __) => FullScreenGallery(
                  title: galleryTitle,
                  gallery: imagesList,
                  initialIndex: index,
                ),
                // context: tabBarProvider.mainContext,
              ),
            ),
            child: Hero(
              tag: imagesList[index] ?? '',
              child: CachedNetworkImage(
                imageUrl: imagesList[index] ?? '',
                imageBuilder: (context, imageProvider) {
                  return Image(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  );
                },
                placeholder: (context, indicator) {
                  return SkeletonLoaderWidget(
                    height: 42.h,
                    width: double.infinity,
                  );
                },
                errorWidget: (context, indicator, error) {
                  return Container(
                    height: 42.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(ConstantsAssets.memorialBookLogoImage),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 1.2.h,
          );
        },
        itemCount: imagesList.length,
      ),
    );
  }
}
