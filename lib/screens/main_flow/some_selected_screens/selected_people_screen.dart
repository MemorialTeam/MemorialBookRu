import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_community_screen.dart';
import 'package:memorial_book/screens/marketplace/home_marketplace_screen.dart';
import 'package:memorial_book/widgets/boot_engine.dart';
import 'package:memorial_book/widgets/grid_gallery_widget.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../models/people/response/get_people_info_response_model.dart';
import '../../../provider/account_provider.dart';
import '../../../widgets/cards/vertical_card_widget.dart';
import '../../../widgets/memorial_app_bar.dart';
import '../../../widgets/home_frame_widget.dart';
import '../../../widgets/platform_scroll_physics.dart';

class SelectedPeopleScreen extends StatefulWidget {
  const SelectedPeopleScreen({
    Key? key,
    required this.id,
    required this.avatar,
  }) : super(key: key);

  final String avatar;
  final int id;

  @override
  State<SelectedPeopleScreen> createState() => _SelectedPeopleScreenState();
}

class _SelectedPeopleScreenState extends State<SelectedPeopleScreen> {
  final ScrollController relatedProfilesController = ScrollController();

  final ScrollController petsController = ScrollController();

  @override
  void initState() {
    final accountProvider = Provider.of<AccountProvider>(
      context,
      listen: false,
    );
    accountProvider.gettingPeopleProfile(context, widget.id);
    super.initState();
  }

  final dataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    GetPeopleInfoResponseModel? modelData = accountProvider.peopleProfileModel;
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: BootEngine(
          loadValue: accountProvider.getPeopleProfileState,
          activeFlow: CustomScrollView(
            physics: platformScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                delegate: MySliverAppBar(
                  expandedHeight: 28.8.h,
                  image: modelData?.human?.avatar ?? '',
                  backgroundImage: modelData?.human?.banner ?? '',
                  emoji: accountProvider.religionIcon(modelData?.human?.religion ?? ''),
                ),
                floating: false,
              ),
              SliverToBoxAdapter(
                child: Column(
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
                          Wrap(
                            children: [
                              Text(
                                '${modelData?.human?.firstName} ${modelData?.human?.middleName != null ? '${modelData?.human?.middleName} ' : ''}',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoBlack,
                                  fontSize: 21.sp,
                                  height: 0.9.sp,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if(modelData?.human?.lastName != null)
                                    Text(
                                      modelData?.human?.lastName ?? '',
                                      style: TextStyle(
                                        fontFamily: ConstantsFonts.latoBlack,
                                        fontSize: 21.sp,
                                        height: 0.9.sp,
                                      ),
                                    ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  if(modelData?.human?.isCelebrity != null && modelData?.human!.isCelebrity == true)
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
                            ],
                          ),
                          SizedBox(
                            height: 1.6.h,
                          ),
                          Text(
                            '${modelData?.human?.dateBirth} - ${modelData?.human?.dateDeath}',
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
                            'Причина смерти: ${modelData?.human?.deathReason ?? 'Не указана'}',
                            style: TextStyle(
                              color: const Color.fromRGBO(32, 30, 31, 0.8),
                              fontSize: 9.5.sp,
                              fontFamily: ConstantsFonts.latoRegular,
                            ),
                          ),
                          SizedBox(
                            height: 1.6.h,
                          ),
                          AutoSizeText(
                            modelData?.human?.description ?? 'Your caption is here',
                            maxLines: 3,
                            style: TextStyle(
                              color: const Color.fromRGBO(32, 30, 31, 0.8),
                              fontSize: 9.5.sp,
                              fontFamily: ConstantsFonts.latoRegular,
                            ),
                            overflowReplacement: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  modelData?.human?.description ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: const Color.fromRGBO(32, 30, 31, 0.8),
                                    fontSize: 9.5.sp,
                                    fontFamily: ConstantsFonts.latoRegular,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Scrollable.ensureVisible(
                                      dataKey.currentContext ?? context,
                                      curve: Curves.easeInOut,
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Показать больше',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(23, 94, 217, 1),
                                      fontSize: 11.5.sp,
                                      fontFamily: ConstantsFonts.latoSemiBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.6.h,
                          ),
                          modelData?.human!.hobbies != null && modelData!.human!.hobbies!.isNotEmpty ?
                          Wrap(
                            children: modelData.human!.hobbies!.map((e) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 9.5.sp,
                                    fontFamily: ConstantsFonts.latoBold,
                                  ),
                                ),
                              ],
                            ),
                            ).map(
                                  (widget) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.h,
                                  vertical: 0.8.h,
                                ),
                                margin: EdgeInsets.only(
                                  right: 1.2.h,
                                  bottom: 1.2.h,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(23, 94, 217, 0.1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                child: widget,
                              ),
                            ).toList(),
                          ) :
                          const SizedBox(),
                          SizedBox(
                            height: 1.6.h,
                          ),
                          MainButton(
                            text: 'Перейти в магазин',
                            onTap: () => Navigator.push(
                              tabBarProvider.mainContext,
                              CupertinoPageRoute(
                                settings: const RouteSettings(
                                  name: ConstantsNavigatorKeys.marketplaceRoute,
                                ),
                                builder: (context) => const HomeMarketplaceScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    modelData?.kinsfolk != null && modelData!.kinsfolk!.isNotEmpty ?
                    Column(
                      children: [
                        HomeFrameWidget(
                          title: 'Kinsfolk',
                          controller: relatedProfilesController,
                          widget: SizedBox(
                            height: 26.h,
                            child: ListView(
                              controller: relatedProfilesController,
                              scrollDirection: Axis.horizontal,
                              physics: platformScrollPhysics(),
                              children: [
                                SizedBox(
                                  width: 3.2.w,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: modelData.kinsfolk!.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final dataList = modelData.kinsfolk![index];
                                    return VerticalCardWidget(
                                      onTap: () => Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => SelectedPeopleScreen(
                                            id: dataList.id ?? 0,
                                            avatar: dataList.avatar ?? '',
                                          ),
                                        ),
                                      ),
                                      subtitle: '${dataList.dateBirth} y.',
                                      title: dataList.fullName,
                                      avatar: dataList.avatar,
                                      isCelebrity: false,
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 3.2.w,
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 3.2.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //     vertical: 2.4.h,
                        //   ),
                        //   color: const Color.fromRGBO(255, 255, 255, 1),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Padding(
                        //         padding: EdgeInsets.symmetric(
                        //           horizontal: 2.h,
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           crossAxisAlignment: CrossAxisAlignment.end,
                        //           children: [
                        //             Text(
                        //               'Kinsfolk',
                        //               style: TextStyle(
                        //                 fontFamily: ConstantsFonts.latoBold,
                        //                 fontSize: 14.sp,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: 2.4.h,
                        //       ),
                        //       LimitedBox(
                        //         maxHeight: 25.h,
                        //         child: ListView(
                        //           controller: relatedProfilesController,
                        //           shrinkWrap: true,
                        //           scrollDirection: Axis.horizontal,
                        //           physics: const BouncingScrollPhysics(),
                        //           children: [
                        //             SizedBox(
                        //               width: 2.h,
                        //             ),
                        //             ListView.separated(
                        //               shrinkWrap: true,
                        //               itemCount: modelData.kinsfolk!.length,
                        //               scrollDirection: Axis.horizontal,
                        //               physics: const NeverScrollableScrollPhysics(),
                        //               itemBuilder: (context, index) {
                        //                 KinsfolkInfoResponseModel kinsfolkData = modelData.kinsfolk![index];
                        //                 return GestureDetector(
                        //                   onTap: () {
                        //                     accountProvider.gettingPeopleProfile(context, kinsfolkData.id!, (model) {
                        //                       if(model!.status == true) {
                        //                         Navigator.push(
                        //                           context,
                        //                           CupertinoPageRoute(
                        //                             builder: (context) => SelectedPeopleScreen(
                        //                               model: model,
                        //                             ),
                        //                           ),
                        //                         );
                        //                       }
                        //                     });
                        //                   },
                        //                   child: Column(
                        //                     mainAxisSize: MainAxisSize.min,
                        //                     children: [
                        //                       CachedNetworkImage(
                        //                         imageUrl: kinsfolkData.avatar!,
                        //                         imageBuilder: (context, imageProvider) {
                        //                           return Container(
                        //                             width: 28.w,
                        //                             height: 18.3.h,
                        //                             decoration: BoxDecoration(
                        //                               borderRadius: BorderRadius.circular(5),
                        //                               image: DecorationImage(
                        //                                 image: imageProvider,
                        //                                 fit: BoxFit.cover,
                        //                               ),
                        //                             ),
                        //                           );
                        //                         },
                        //                         progressIndicatorBuilder: (context, url, downloadProgress) {
                        //                           return SkeletonLoaderWidget(
                        //                             width: 28.w,
                        //                             height: 18.3.h,
                        //                             borderRadius: 5,
                        //                           );
                        //                         },
                        //                       ),
                        //                       SizedBox(
                        //                         height: 1.4.h,
                        //                       ),
                        //                       Text(
                        //                         '${kinsfolkData.dateBirth} - ${kinsfolkData.dateDeath} y.',
                        //                         style: TextStyle(
                        //                           fontSize: 9.sp,
                        //                           fontFamily: ConstantsFonts.latoRegular,
                        //                         ),
                        //                       ),
                        //                       SizedBox(
                        //                         height: 0.6.h,
                        //                       ),
                        //                       Text(
                        //                         kinsfolkData.fullName ?? 'User',
                        //                         textAlign: TextAlign.center,
                        //                         style: TextStyle(
                        //                           fontSize: 10.sp,
                        //                           fontFamily: ConstantsFonts.latoBold,
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 );
                        //               },
                        //               separatorBuilder: (BuildContext context, int index) {
                        //                 return SizedBox(
                        //                   width: 1.6.h,
                        //                 );
                        //               },
                        //             ),
                        //             SizedBox(
                        //               width: 2.h,
                        //             ),
                        //             // Column(
                        //             //   mainAxisSize: MainAxisSize.min,
                        //             //   children: [
                        //             //     Container(
                        //             //       width: 100,
                        //             //       height: 134,
                        //             //       decoration: BoxDecoration(
                        //             //         borderRadius: BorderRadius.circular(5),
                        //             //         color: const Color.fromRGBO(241, 241, 241, 1),
                        //             //       ),
                        //             //       child: Center(
                        //             //         child: Icon(
                        //             //           CupertinoIcons.plus,
                        //             //           size: 3.h,
                        //             //           color: Colors.grey,
                        //             //         ),
                        //             //       ),
                        //             //     ),
                        //             //   ],
                        //             // ),
                        //             // SizedBox(
                        //             //   width: 1.6.h,
                        //             // ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 1.6.h,
                        ),
                      ],
                    ) :
                    const SizedBox(),
                    modelData?.human!.gallery != null && modelData!.human!.gallery!.isNotEmpty ?
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 3.h,
                      ),
                      child: GridGalleryWidget(
                        images: modelData.human!.gallery!,
                        title: '${modelData.human?.firstName}${modelData.human?.middleName != null ? ' ${modelData.human?.middleName}' : ''}${modelData.human?.lastName != null ? ' ${modelData.human?.lastName}' : modelData.human?.lastName}',
                      ),
                    ) :
                    const SizedBox(),
                    HomeFrameWidget(
                      key: dataKey,
                      title: 'Описание',
                      widget: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.2.w,
                        ),
                        child: Text(
                          modelData?.human?.description ?? '',
                          style: TextStyle(
                            color: const Color.fromRGBO(32, 30, 31, 0.8),
                            fontSize: 11.5.sp,
                            fontFamily: ConstantsFonts.latoRegular,
                            height: 1.2.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
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
                          width: 86.w,
                          borderRadius: 10,
                        ),
                        SizedBox(
                          height: 2.4.h,
                        ),
                        SkeletonLoaderWidget(
                          height: 1.6.h,
                          width: 42.w,
                          borderRadius: 10,
                        ),
                        SizedBox(
                          height: 1.6.h,
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
                          width: double.infinity,
                          borderRadius: 10,
                        ),
                        SizedBox(
                          height: 0.7.h,
                        ),
                        SkeletonLoaderWidget(
                          height: 1.6.h,
                          width: 34.w,
                          borderRadius: 10,
                        ),
                        SizedBox(
                          height: 1.9.h,
                        ),
                        Row(
                          children: [
                            SkeletonLoaderWidget(
                              height: 4.h,
                              width: 54.w,
                              borderRadius: 15,
                            ),
                            SizedBox(
                              width: 2.h,
                            ),
                            SkeletonLoaderWidget(
                              height: 4.h,
                              width: 20.w,
                              borderRadius: 15,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.8.h,
                        ),
                        SkeletonLoaderWidget(
                          height: 4.h,
                          width: 69.w,
                          borderRadius: 15,
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        SkeletonLoaderWidget(
                          height: 6.1.h,
                          width: double.infinity,
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
                    itemCount: 3,
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
    );
  }
}