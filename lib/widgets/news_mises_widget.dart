import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:sizer/sizer.dart';
import 'news_item_widget.dart';

class NewsMisesWidget extends StatelessWidget {
  const NewsMisesWidget({
    Key? key,
    required this.dataParsing,
  }) : super(key: key);

  final Map dataParsing;

  @override
  Widget build(BuildContext context) {
    ScrollController profilesController = ScrollController();
    switch(dataParsing['tag']) {
      case 'multi_images':
        return Container(
          color: const Color.fromRGBO(255, 255, 255, 1),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: dataParsing['creator_information']['avatar_image'],
                      progressIndicatorBuilder: (context, url, downloadProgress) {
                        return SkeletonLoaderWidget(
                          height: 7.h,
                          width: 7.h,
                          borderRadius: 100,
                        );
                      },
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 7.h,
                          width: 7.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, error, widget) {
                        return Container(
                          height: 7.h,
                          width: 7.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: AssetImage(ConstantsAssets.memorialBookLogoImage,),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 2.5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataParsing['creator_information']['name'],
                          style: TextStyle(
                            fontFamily: ConstantsFonts.latoBold,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(
                          height: 0.7.h,
                        ),
                        Text(
                          'Added ${dataParsing['images'].length} new pictures today at 1:56 PM',
                          style: TextStyle(
                            fontFamily: ConstantsFonts.latoBold,
                            fontSize: 8.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.6.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: NewsItemWidget(
                  dataImages: dataParsing['images'],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        );
      case 'added_profiles':
        return Container(
          color: const Color.fromRGBO(255, 255, 255, 1),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: dataParsing['creator_information']['avatar_image'],
                      progressIndicatorBuilder: (context, url, downloadProgress) {
                        return SkeletonLoaderWidget(
                          height: 7.h,
                          width: 7.h,
                          borderRadius: 100,
                        );
                      },
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 7.h,
                          width: 7.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, error, widget) {
                        return Container(
                          height: 7.h,
                          width: 7.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: AssetImage(ConstantsAssets.memorialBookLogoImage,),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 2.5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataParsing['creator_information']['name'],
                          style: TextStyle(
                            fontFamily: ConstantsFonts.latoBold,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(
                          height: 0.7.h,
                        ),
                        Text(
                          'Added ${dataParsing['added_profiles'].length} new pictures today at 1:56 PM',
                          style: TextStyle(
                            fontFamily: ConstantsFonts.latoBold,
                            fontSize: 8.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.6.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  '${dataParsing['added_profiles'].length} profiles were added.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 9.5.sp,
                    fontFamily: ConstantsFonts.latoRegular,
                  ),
                ),
              ),
              SizedBox(
                height: 1.6.h,
              ),
              LimitedBox(
                maxHeight: 194,
                child: ListView(
                  controller: profilesController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: dataParsing['added_profiles'].length,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, indexImages) {
                        final addedProfilesData = dataParsing['added_profiles'][indexImages];
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   CupertinoPageRoute(
                            //     builder: (context) => const SelectedPetScreen(),
                            //   ),
                            // );
                          },
                          child: SizedBox(
                            width: 28.w,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: addedProfilesData['profile_image'],
                                  progressIndicatorBuilder: (context, url, downloadProgress) {
                                    return SkeletonLoaderWidget(
                                      height: 18.h,
                                      width: 28.w,
                                      borderRadius: 5,
                                    );
                                  },
                                  errorWidget: (context, error, widget) {
                                    return Container(
                                      height: 18.h,
                                      width: 28.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: AssetImage(ConstantsAssets.memorialBookLogoImage),
                                        ),
                                      ),
                                    );
                                  },
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      height: 18.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 1.4.h,
                                ),
                                Text(
                                  '${addedProfilesData['year_from']} - ${addedProfilesData['year_to']} y.',
                                  style: TextStyle(
                                    fontSize: 8.4.sp,
                                    fontFamily: ConstantsFonts.latoRegular,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  addedProfilesData['profile_name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: ConstantsFonts.latoBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
