import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_community_screen.dart';
import 'package:memorial_book/widgets/open_image_core.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../models/pet/response/get_pet_info_response_model.dart';
import '../../../provider/account_provider.dart';
import '../../../widgets/memorial_app_bar.dart';
import '../../../widgets/skeleton_loader_widget.dart';

class SelectedPetScreen extends StatelessWidget {
  const SelectedPetScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  final GetPetInfoResponseModel model;

  @override
  Widget build(BuildContext context) {
    final petData = model.pet!;
    final accountProvider = Provider.of<AccountProvider>(context);
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: Scaffold(
        body: SafeArea(
          child: Material(
            color: const Color.fromRGBO(245, 247, 249, 1),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  delegate: MySliverAppBar(
                    expandedHeight: 28.8.h,
                    image: model.pet!.avatar!,
                    backgroundImage: model.pet!.banner!,
                    emoji: ConstantsAssets.petEmojiImage,
                    paddingEmoji: EdgeInsets.all(0.8.h),
                  ),
                  floating: false,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
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
                            Text(
                              petData.name!,
                              style: TextStyle(
                                fontFamily: ConstantsFonts.latoBlack,
                                fontSize: 21.sp,
                              ),
                            ),
                            SizedBox(
                              height: 1.6.h,
                            ),
                            Text(
                              '${petData.dateBirth} - ${petData.dateDeath}',
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
                              'Death cause: ${petData.deathReason ?? 'Not specified'}',
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
                              petData.description!,
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
                      petData.gallery != null && petData.gallery!.isNotEmpty ?
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 0.2.h,
                          crossAxisSpacing: 0.2.h,
                        ),
                        itemCount: petData.gallery!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OpenImage(
                            initialIndex: index,
                            disposeLevel: DisposeLevel.High,
                            dataImage: petData.gallery!,
                            child: CachedNetworkImage(
                              imageUrl: petData.gallery![index],
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}