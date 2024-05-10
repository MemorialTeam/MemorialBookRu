import 'package:flutter/cupertino.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_community_screen.dart';
import 'package:memorial_book/screens/marketplace/home_marketplace_screen.dart';
import 'package:memorial_book/widgets/grid_gallery_widget.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../models/people/response/get_people_info_response_model.dart';
import '../../../provider/account_provider.dart';
import '../../../widgets/cards/vertical_card_widget.dart';
import '../../../widgets/memorial_app_bar.dart';
import '../../../widgets/home_frame_widget.dart';

class SelectedPeopleScreen extends StatelessWidget {
  SelectedPeopleScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  final GetPeopleInfoResponseModel model;

  final ScrollController relatedProfilesController = ScrollController();
  final ScrollController petsController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    GetPeopleInfoResponseModel modelData = model;
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                delegate: MySliverAppBar(
                  expandedHeight: 28.8.h,
                  image: modelData.human?.avatar ?? '',
                  backgroundImage: modelData.human?.banner ?? '',
                  emoji: accountProvider.religionIcon(modelData.human?.religion ?? ''),
                ),
                floating: false,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
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
                          '${modelData.human?.firstName}${modelData.human?.middleName != null ? ' ${modelData.human?.middleName}' : ''}${modelData.human?.lastName != null ? ' ${modelData.human?.lastName}' : modelData.human?.lastName}',
                          style: TextStyle(
                            fontFamily: ConstantsFonts.latoBlack,
                            fontSize: 21.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.6.h,
                        ),
                        Text(
                          '${modelData.human?.dateBirth} - ${modelData.human?.dateDeath}',
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
                          'Death cause: ${modelData.human?.deathReason ?? 'Not specified'}',
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
                          modelData.human?.description ?? '',
                          style: TextStyle(
                            color: const Color.fromRGBO(32, 30, 31, 0.8),
                            fontSize: 9.5.sp,
                            fontFamily: ConstantsFonts.latoRegular,
                          ),
                        ),
                        SizedBox(
                          height: 1.6.h,
                        ),
                        model.human!.hobbies != null && model.human!.hobbies!.isNotEmpty ?
                        Wrap(
                          children: model.human!.hobbies!.map((e) => Row(
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
                          text: 'BUY FLOWERS OR SERVICE',
                          onTap: () => Navigator.push(
                            tabBarProvider.mainContext,
                            CupertinoPageRoute(
                              builder: (context) => const HomeMarketplaceScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  modelData.kinsfolk != null && modelData.kinsfolk!.isNotEmpty ?
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
                            physics: const BouncingScrollPhysics(),
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
                                    onTap: () => accountProvider.gettingPeopleProfile(context, dataList.id ?? 0, (model) {
                                      if(model!.status == true) {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => SelectedPeopleScreen(
                                              model: model,
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                                    subtitle: '${dataList.dateBirth} y.',
                                    title: dataList.fullName,
                                    avatar: dataList.avatar,
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
                  modelData.human!.gallery != null && modelData.human!.gallery!.isNotEmpty ?
                  GridGalleryWidget(
                    images: modelData.human!.gallery!,
                  ) :
                  const SizedBox(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}