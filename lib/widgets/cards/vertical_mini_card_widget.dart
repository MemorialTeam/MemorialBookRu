import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../skeleton_loader_widget.dart';

class VerticalMiniCardWidget extends StatelessWidget {
  const VerticalMiniCardWidget({
    Key? key,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.avatar,
    required this.banner,
    this.color,
  }) : super(key: key);

  final void Function()? onTap;

  final String? title;
  final String? subtitle;
  final String? avatar;
  final String? banner;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return PunchingAnimation(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 19.h,
          width: 42.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromRGBO(244, 247, 250, 1),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  height: 9.h,
                  width: 42.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromRGBO(244, 247, 250, 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.2.w,
                      vertical: 1.2.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            fontFamily: ConstantsFonts.latoBold,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          subtitle ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            fontFamily: ConstantsFonts.latoBold,
                            color: const Color.fromRGBO(32, 30, 31, 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CachedNetworkImage(
                width: double.infinity,
                height: 11.5.h,
                imageUrl: banner ?? '',
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
                errorWidget: (context, error, widget) {
                  return Container(
                    width: 42.w,
                    height: 11.3.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.asset(
                      ConstantsAssets.memorialBookLogoImage,
                      color: color,
                    ),
                  );
                },
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return SkeletonLoaderWidget(
                    width: 42.w,
                    height: 11.3.h,
                    borderRadius: 5,
                  );
                },
              ),
              Positioned(
                top: 7.4.h,
                left: 1.h,
                child: Container(
                  width: 5.4.h,
                  height: 5.4.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: CachedNetworkImage(
                        imageUrl: avatar ?? '',
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, error, _) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Image.asset(
                              ConstantsAssets.memorialBookLogoImage,
                              color: color,
                            ),
                          );
                        },
                        progressIndicatorBuilder: (context, url, downloadProgress) {
                          return const SkeletonLoaderWidget(
                            height: double.infinity,
                            width: double.infinity,
                            borderRadius: 30,
                          );
                        },
                      ),
                    ),
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
