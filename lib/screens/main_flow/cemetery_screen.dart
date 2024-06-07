import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/communities_user_subscribed_screen.dart';
import 'package:memorial_book/screens/flow_build.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_cemetery_screen.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_core.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../provider/account_provider.dart';
import '../../provider/catalog_provider.dart';
import '../../widgets/cards/horizontal_mini_card_widget.dart';
import '../../widgets/cards/vertical_mini_card_widget.dart';
import '../../widgets/home_frame_skeleton_widget.dart';
import '../../widgets/home_frame_widget.dart';
import '../../widgets/platform_scroll_physics.dart';
import '../../widgets/skeleton_loader_widget.dart';

class CemeteryScreen extends StatefulWidget {
  const CemeteryScreen({Key? key}) : super(key: key);

  @override
  State<CemeteryScreen> createState() => _CemeteryScreenState();
}

class _CemeteryScreenState extends State<CemeteryScreen> {

  final ScrollController featuredCommunitiesController = ScrollController();
  final FocusNode cemeteryFocusNode = FocusNode();

  @override
  void initState() {
    final _catalogProvider = Provider.of<CatalogProvider>(context, listen: false);
    _catalogProvider.gettingCemeteries(context, (model) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      colorIcon: const Color.fromRGBO(18, 175, 82, 1),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: ValueListenableBuilder(
          valueListenable: accountProvider.user,
          builder: (context, data, _) => FlowBuild(
            loadingFlow: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 1.2.h,
                ),
                HomeFrameSkeletonWidget(
                  width: 44,
                  widget: LimitedBox(
                    maxHeight: 21.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          width: 3.2.w,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SkeletonLoaderWidget(
                              height: double.infinity,
                              width: 42.w,
                              borderRadius: 5,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 2.w,
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
                SizedBox(
                  height: 1.2.h,
                ),
                Container(
                  height: 9.h,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.2.w,
                    vertical: 1.2.h,
                  ),
                  child: const SkeletonLoaderWidget(
                    height: double.infinity,
                    width: double.infinity,
                    borderRadius: 7,
                  ),
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                Container(
                  height: 7.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.2.w,
                    vertical: 1.4.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLoaderWidget(
                        height: 3.2.h,
                        width: 45.w,
                        borderRadius: 14,
                      ),
                      SkeletonLoaderWidget(
                        width: 4.h,
                        height: 4.h,
                        borderRadius: 7,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.5
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkeletonLoaderWidget(
                            width: 7.h,
                            height: 7.h,
                            borderRadius: 1000,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          SizedBox(
                            width: 62.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SkeletonLoaderWidget(
                                  width: 16.h,
                                  height: 2.h,
                                  borderRadius: 14,
                                ),
                                SizedBox(
                                  height: 0.4.h,
                                ),
                                SkeletonLoaderWidget(
                                  width: 34.h,
                                  height: 1.7.h,
                                  borderRadius: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 2.6.h,
                      );
                    },
                  ),
                ),
              ],
            ),
            activeFlow: ListView(
              physics: platformScrollPhysics(),
              children: [
                SizedBox(
                  height: 1.2.h,
                ),
                Container(
                  height: 9.h,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.2.w,
                    vertical: 1.2.h,
                  ),
                  child: SearchEngine(
                    focusNode: cemeteryFocusNode,
                    controller: catalogProvider.cemeteryController,
                    isNotEmptyFunc: (text) => catalogProvider.cemeterySearch(),
                    isEmptyFunc: () => catalogProvider.gettingCemeteries(context, (model) {}),
                    isSearching: catalogProvider.isCemeterySearch,
                    activeColor: const Color.fromRGBO(18, 175, 82, 1),
                  ),
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                catalogProvider.cemeteryList.isNotEmpty ?
                Container(
                  height: 7.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.2.w,
                    vertical: 1.4.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cemetery you follow',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: ConstantsFonts.latoBold,
                        ),
                      ),
                      Container(
                        width: 4.h,
                        height: 4.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color.fromRGBO(229, 232, 235, 1),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const CommunitiesUserSubscribedScreen(
                                    flowIs: 'Cemetery',
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(7),
                            child: Center(
                              child: Image.asset(
                                ConstantsAssets.iosArrowRightImage,
                                height: 1.4.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ) :
                const SizedBox(),
                catalogProvider.cemeteryList.isEmpty ?
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 3.8.h,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        ConstantsAssets.placesTabBarImage,
                        height: 5.8.h,
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      Text(
                        'There\'s nothing here yet',
                        style: TextStyle(
                          fontFamily: ConstantsFonts.latoBold,
                          fontSize: 11.5.sp,
                        ),
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color.fromRGBO(18, 175, 82, 1),
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () async =>
                                await Navigator.maybePop(context).whenComplete(
                                      () => tabBarProvider.selectTab(TabItem.places),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.8.h,
                                    horizontal: 5.w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+ ADD CEMETERY',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(18, 175, 82, 1),
                                        fontSize: 8.5.sp,
                                        fontFamily: ConstantsFonts.latoBold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ) :
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.5
                      ),
                    ),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: catalogProvider.cemeteryList.length > 6 ?
                    6 :
                    catalogProvider.cemeteryList.length,
                    itemBuilder: (context, index) {
                      final dataList = catalogProvider.cemeteryList[index];
                      return HorizontalMiniCardWidget(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SelectedCemeteryScreen(
                              avatar: dataList.avatar ?? '',
                              id: dataList.id ?? 0,
                            ),
                          ),
                        ),
                        avatar: dataList.avatar,
                        title: dataList.title ?? '',
                        subtitle: dataList.subtitle ?? '',
                        color: const Color.fromRGBO(18, 175, 82, 1),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 2.6.h,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                HomeFrameWidget(
                  title: 'Featured Cemetery',
                  controller: featuredCommunitiesController,
                  widget: SizedBox(
                    height: 19.h,
                    child: ListView(
                      controller: featuredCommunitiesController,
                      scrollDirection: Axis.horizontal,
                      physics: platformScrollPhysics(),
                      children: [
                        SizedBox(
                          width: 3.2.w,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: catalogProvider.featuredCemeteriesList.length,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final dataList = catalogProvider.featuredCemeteriesList[index];
                            return VerticalMiniCardWidget(
                              onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SelectedCemeteryScreen(
                                    avatar: dataList.avatar ?? '',
                                    id: dataList.id ?? 0,
                                  ),
                                ),
                              ),
                              title: dataList.name,
                              subtitle: dataList.address,
                              avatar: dataList.avatar,
                              banner: dataList.banner,
                              color: const Color.fromRGBO(18, 175, 82, 1),
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
                SizedBox(
                  height: 1.2.h,
                ),
              ],
            ),
            errorText: data?.message ?? 'Error',
          ),
        ),
      ),
    );
  }
}

