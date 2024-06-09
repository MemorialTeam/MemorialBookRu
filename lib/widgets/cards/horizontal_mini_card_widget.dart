import 'package:cached_network_image/cached_network_image.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/enums.dart';

class HorizontalMiniCardWidget extends StatefulWidget {
  const HorizontalMiniCardWidget({
    Key? key,
    required this.onTap,
    required this.avatar,
    required this.title,
    required this.subtitle,
    this.isAddingPeople,
    this.isVerified,
    this.index,
    this.id,
    this.color,
    this.status,
  }) : super(key: key);

  final void Function()? onTap;

  final int? index;
  final int? id;

  final String title;
  final String? avatar;
  final String subtitle;

  final bool? isAddingPeople;
  final bool? isVerified;

  final Color? color;

  final ProfileStatus? status;

  @override
  State<HorizontalMiniCardWidget> createState() => _HorizontalMiniCardWidgetState();
}

class _HorizontalMiniCardWidgetState extends State<HorizontalMiniCardWidget> {

  Widget totalStatus() {
    if(widget.status != null) {
      switch(widget.status) {
        case ProfileStatus.active:
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 0.3.h,
              horizontal: 1.2.w,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(23, 94, 217, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Активный',
              style: TextStyle(
                color: Colors.white,
                fontFamily: ConstantsFonts.latoRegular,
                fontSize: 7.5.sp,
              ),
            ),
          );
        case ProfileStatus.private:
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 0.3.h,
              horizontal: 1.w,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(250, 18, 46, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Приватный',
              style: TextStyle(
                color: Colors.white,
                fontFamily: ConstantsFonts.latoRegular,
                fontSize: 6.5.sp,
              ),
            ),
          );
        case ProfileStatus.draft:
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 0.3.h,
              horizontal: 1.w,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(229, 232, 235, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Черновик',
              style: TextStyle(
                color: Colors.black,
                fontFamily: ConstantsFonts.latoRegular,
                fontSize: 6.5.sp,
              ),
            ),
          );
        case ProfileStatus.none:
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 0.3.h,
              horizontal: 1.w,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(229, 232, 235, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Неизвестный статус',
              style: TextStyle(
                color: Colors.black,
                fontFamily: ConstantsFonts.latoRegular,
                fontSize: 6.5.sp,
              ),
            ),
          );
        case null:
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 0.3.h,
              horizontal: 1.w,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(229, 232, 235, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Ошибка',
              style: TextStyle(
                color: Colors.black,
                fontFamily: ConstantsFonts.latoRegular,
                fontSize: 6.5.sp,
              ),
            ),
          );
      }
    } else {
      return const SizedBox();
    }
  }

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
                        totalStatus(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontFamily: ConstantsFonts.latoRegular,
                                fontSize: 11.5.sp,
                              ),
                            ),
                            if(widget.isVerified == true) Padding(
                              padding: EdgeInsets.only(
                                bottom: 0.2.h,
                              ),
                              child: Image.asset(
                                ConstantsAssets.verifiedImage,
                                height: 1.4.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: widget.status == null ?
                          0.6.h :
                          0.1.h,
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
          ),
        ),
      ),
    );
  }
}
