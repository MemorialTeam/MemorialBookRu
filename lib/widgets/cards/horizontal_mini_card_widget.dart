import 'package:cached_network_image/cached_network_image.dart';
import 'package:memorial_book/models/communitites/request/add_memorial_to_the_commnunity_request_model.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/constants.dart';
import 'package:sizer/sizer.dart';
import '../../provider/catalog_provider.dart';

enum StateOfMemorial {
  added,
  notAdded,
}

class HorizontalMiniCardWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    return PunchingAnimation(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Container(
            decoration: isAddingPeople == true ?
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
                          imageUrl: avatar ?? '',
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
                                color: color,
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
                                title,
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 11.5.sp,
                                ),
                              ),
                              SizedBox(
                                height: 0.6.h,
                              ),
                              Text(
                                subtitle,
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
                  isAddingPeople == true ?
                  catalogProvider.stateAddWidget(
                    catalogProvider.isAdded(index ?? 0),
                    context,
                    catalogProvider.selectedCommunity.id ?? 0,
                    AddMemorialToTheCommunityRequestModel(
                      memorialId: id ?? 0,
                      memorialType: 'human',
                    ),
                  ) :
                  const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
