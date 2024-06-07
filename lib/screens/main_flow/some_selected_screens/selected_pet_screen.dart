import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_community_screen.dart';
import 'package:memorial_book/widgets/boot_engine.dart';
import 'package:memorial_book/widgets/open_image_core.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../models/pet/response/get_pet_info_response_model.dart';
import '../../../provider/account_provider.dart';
import '../../../widgets/memorial_app_bar.dart';
import '../../../widgets/platform_scroll_physics.dart';
import '../../../widgets/skeleton_loader_widget.dart';

class SelectedPetScreen extends StatefulWidget {
  const SelectedPetScreen({
    Key? key,
    required this.id,
    required this.avatar,
  }) : super(key: key);

  final String avatar;
  final int id;

  @override
  State<SelectedPetScreen> createState() => _SelectedPetScreenState();
}

class _SelectedPetScreenState extends State<SelectedPetScreen> {

  @override
  void initState() {
    final accountProvider = Provider.of<AccountProvider>(
      context,
      listen: false,
    );
    accountProvider.gettingPetProfile(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    GetPetInfoResponseModel? modelData = accountProvider.petProfileModel;
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: Scaffold(
        body: SafeArea(
          child: Material(
            color: const Color.fromRGBO(245, 247, 249, 1),
            child: BootEngine(
              loadValue: accountProvider.getPetProfileState,
              activeFlow: CustomScrollView(
                physics: platformScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(
                      expandedHeight: 28.8.h,
                      image: modelData?.pet?.avatar ?? '',
                      backgroundImage: modelData?.pet?.banner ?? '',
                      emoji: ConstantsAssets.petEmojiImage,
                      paddingEmoji: EdgeInsets.all(0.8.h),
                    ),
                    floating: false,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5.h,
                            right: 2.h,
                            left: 2.h,
                            bottom: 1.6.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    modelData?.pet?.name ?? '',
                                    style: TextStyle(
                                      fontFamily: ConstantsFonts.latoBlack,
                                      fontSize: 21.sp,
                                      height: 0.9.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  if(modelData?.pet?.isCelebrity != null && modelData?.pet!.isCelebrity == true)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 0.2.h,
                                      ),
                                      child: Image.asset(
                                        ConstantsAssets.verifiedImage,
                                        height: 2.h,
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 1.6.h,
                              ),
                              Text(
                                '${modelData?.pet?.dateBirth} - ${modelData?.pet?.dateDeath}',
                                style: TextStyle(
                                  color: const Color.fromRGBO(32, 30, 31, 0.8),
                                  fontSize: 9.5.sp,
                                  fontFamily: ConstantsFonts.latoRegular,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                'Причина смерти: ${modelData?.pet?.deathReason ?? 'Не указана'}',
                                style: TextStyle(
                                  color: const Color.fromRGBO(32, 30, 31, 0.8),
                                  fontSize: 9.5.sp,
                                  fontFamily: ConstantsFonts.latoRegular,
                                ),
                              ),
                              SizedBox(
                                height: 1.6.h,
                              ),
                              Text(
                                modelData?.pet?.description ?? '',
                                style: TextStyle(
                                  color: const Color.fromRGBO(32, 30, 31, 0.8),
                                  fontSize: 9.5.sp,
                                  fontFamily: ConstantsFonts.latoRegular,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.6.h,
                        ),
                        modelData?.pet?.gallery != null && modelData!.pet!.gallery!.isNotEmpty ?
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 0.2.h,
                            crossAxisSpacing: 0.2.h,
                          ),
                          itemCount: modelData.pet?.gallery?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return OpenImage(
                              initialIndex: index,
                              disposeLevel: DisposeLevel.High,
                              dataImage: modelData.pet?.gallery ?? [],
                              child: CachedNetworkImage(
                                imageUrl: modelData.pet?.gallery?[index] ?? '',
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
                        ) :
                        const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              loadingFlow: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 28.8.h,
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        SkeletonLoaderWidget(
                          height: 28.8.h,
                          width: double.infinity,
                        ),
                        Positioned(
                          top: 28.8.h / 2.14,
                          left: 5.5.w,
                          child: CachedNetworkImage(
                            imageUrl: widget.avatar,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 19.h,
                                width: 19.h,
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(3, 5),
                                        blurRadius: 30,
                                        spreadRadius: 0,
                                        color: Color.fromRGBO(0, 0, 0, 0.05),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            errorWidget: (context, error, widget) {
                              return Container(
                                height: 19.h,
                                width: 19.h,
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(3, 5),
                                      blurRadius: 30,
                                      spreadRadius: 0,
                                      color: Color.fromRGBO(0, 0, 0, 0.05),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    ConstantsAssets.memorialBookLogoImage,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            progressIndicatorBuilder: (context, url, downloadProgress) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SkeletonLoaderWidget(
                                  height: 19.h,
                                  width: 19.h,
                                  borderRadius: 100,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5.4.h,
                          right: 2.h,
                          left: 2.h,
                          bottom: 1.6.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonLoaderWidget(
                              height: 3.h,
                              width: 46.w,
                              borderRadius: 10,
                            ),
                            SizedBox(
                              height: 2.4.h,
                            ),
                            SkeletonLoaderWidget(
                              height: 1.6.h,
                              width: 38.w,
                              borderRadius: 10,
                            ),
                            SizedBox(
                              height: 1.7.h,
                            ),
                            SkeletonLoaderWidget(
                              height: 1.6.h,
                              width: 50.w,
                              borderRadius: 10,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            SkeletonLoaderWidget(
                              height: 1.6.h,
                              width: 64.w,
                              borderRadius: 10,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            SkeletonLoaderWidget(
                              height: 1.6.h,
                              width: double.infinity,
                              borderRadius: 10,
                            ),
                            SizedBox(
                              height: 0.7.h,
                            ),
                            SkeletonLoaderWidget(
                              height: 1.6.h,
                              width: double.infinity,
                              borderRadius: 10,
                            ),
                            SizedBox(
                              height: 0.7.h,
                            ),
                            SkeletonLoaderWidget(
                              height: 1.6.h,
                              width: double.infinity,
                              borderRadius: 10,
                            ),
                            SizedBox(
                              height: 0.7.h,
                            ),
                            SkeletonLoaderWidget(
                              height: 1.6.h,
                              width: 72.w,
                              borderRadius: 10,
                            ),
                          ],
                        ),
                      ),
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
                          return SkeletonLoaderWidget(
                            height: 28.h,
                            width: double.infinity,
                          );
                        },
                      ),
                    ],
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