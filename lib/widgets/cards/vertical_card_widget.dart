import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../skeleton_loader_widget.dart';

class VerticalCardWidget extends StatelessWidget {
  const VerticalCardWidget({
    Key? key,
    required this.onTap,
    required this.subtitle,
    required this.title,
    required this.avatar,
  }) : super(key: key);

  final void Function()? onTap;

  final String? subtitle;
  final String? title;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return PunchingAnimation(
      child: SizedBox(
        width: 28.w,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                width: double.infinity,
                height: 18.h,
                imageUrl: avatar ?? '',
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return SkeletonLoaderWidget(
                    width: 28.w,
                    height: 18.3.h,
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
                  );
                },
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Text(
                subtitle ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 8.5.sp,
                  fontFamily: ConstantsFonts.latoRegular,
                ),
              ),
              SizedBox(
                height: 0.7.h,
              ),
              Expanded(
                child: Text(
                  title?.replaceAll(' ', '\n') ?? '',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    fontFamily: ConstantsFonts.latoBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
