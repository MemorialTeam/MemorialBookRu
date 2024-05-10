import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/models/cemetery/response/getting_the_users_cemeteries_response_model.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:provider/provider.dart';
import '../helpers/constants.dart';
import 'package:sizer/sizer.dart';

import '../models/cemetery/response/get_cemetery_info_response_model.dart';
import '../provider/account_provider.dart';
import '../provider/catalog_provider.dart';
import '../screens/main_flow/some_selected_screens/selected_cemetery_screen.dart';

class MapsPlacesCardWidget extends StatelessWidget {
  const MapsPlacesCardWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final CemeteriesResponseModel model;

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    return PunchingAnimation(
      child: GestureDetector(
        onTap: () {
          catalogProvider.gettingCemeteryProfile(context, model.id ?? 0, (model) {
            if(model!.status == true) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const SelectedCemeteryScreen(
                  ),
                ),
              );
            }
          });
        },
        child: SizedBox(
          height: 22.h,
          child: Stack(
            children: [
              CachedNetworkImage(
                width: double.infinity,
                height: 15.h,
                imageUrl: model.banner ?? '',
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return SkeletonLoaderWidget(
                    height: 16.h,
                    width: double.infinity,
                    borderRadius: 5,
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      )
                    ),
                  );
                },
                errorWidget: (context, error, widget) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(ConstantsAssets.memorialBookLogoImage,),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                top: 18.h,
                right: 0.0,
                left: 0.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title ?? 'Cemetery',
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        fontFamily: ConstantsFonts.latoBold,
                        color: const Color.fromRGBO(32, 30, 31, 1),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.h,
                    ),
                    Text(
                      model.subtitle ?? 'Cemetery',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        fontFamily: ConstantsFonts.latoRegular,
                        color: const Color.fromRGBO(32, 30, 31, 0.8),
                      ),
                    ),
                    SizedBox(
                      height: 1.4.h,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5.8.h,
                left: 3.4.w,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0.56.h),
                    child: Center(
                      child: CachedNetworkImage(
                        width: 9.8.h,
                        height: 9.8.h,
                        imageUrl: model.banner ?? '',
                        progressIndicatorBuilder: (context, url, downloadProgress) {
                          return const SkeletonLoaderWidget(
                            width: double.infinity,
                            height: double.infinity,
                            borderRadius: 100,
                          );
                        },
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, error, widget) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(ConstantsAssets.communityTestAvatarImage),
                                  fit: BoxFit.cover,
                                )
                            ),
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
