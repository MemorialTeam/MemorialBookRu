import 'package:cached_network_image/cached_network_image.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import 'package:sizer/sizer.dart';

enum StateOfMemorial {
  added,
  notAdded,
}

class HorizontalMiniCardWidget extends StatefulWidget {
  const HorizontalMiniCardWidget({
    Key? key,
    required this.onTap,
    required this.avatar,
    required this.title,
    required this.subtitle,
    this.isAddingPeople,
    this.index,
    this.id,
    this.color,
  }) : super(key: key);

  final void Function()? onTap;

  final String? avatar;
  final int? id;
  final String title;
  final String subtitle;

  final bool? isAddingPeople;

  final int? index;

  final Color? color;

  @override
  State<HorizontalMiniCardWidget> createState() => _HorizontalMiniCardWidgetState();
}

class _HorizontalMiniCardWidgetState extends State<HorizontalMiniCardWidget> {

  @override
  Widget build(BuildContext context) {
    return PunchingAnimation(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: widget.onTap,
          child: Container(
            decoration: widget.isAddingPeople == true ?
            BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(255, 255, 255, 1),
            ) :
            null,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.6.w,
                vertical: 1.2.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.avatar ?? '',
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 7.h,
                              width: 7.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, indicator, error) {
                            return Container(
                              height: 7.h,
                              width: 7.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                ConstantsAssets.memorialBookLogoImage,
                                color: widget.color,
                              ),
                            );
                          },
                          placeholder: (context, indicator) {
                            return SkeletonLoaderWidget(
                              height: 7.h,
                              width: 7.h,
                              borderRadius: 100,
                            );
                          },
                        ),
                        SizedBox(
                          width: 3.8.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 11.5.sp,
                                ),
                              ),
                              SizedBox(
                                height: 0.6.h,
                              ),
                              Text(
                                widget.subtitle,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 9.5.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
