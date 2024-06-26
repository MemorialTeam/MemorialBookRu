import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/communities_user_subscribed_screen.dart';
import 'package:memorial_book/screens/flow_build.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_community_screen.dart';
import 'package:memorial_book/widgets/cards/vertical_mini_card_widget.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/cards/horizontal_mini_card_widget.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/enums.dart';
import '../../provider/account_provider.dart';
import '../../provider/auth_provider.dart';
import '../../provider/catalog_provider.dart';
import '../../widgets/home_frame_skeleton_widget.dart';
import '../../widgets/home_frame_widget.dart';
import '../../widgets/memorial_book_icon_widget.dart';
import '../../widgets/platform_scroll_physics.dart';
import '../../widgets/skeleton_loader_widget.dart';
import '../../widgets/text_field_search_widget.dart';
import '../profile_creation_flow/creation_flow.dart';

class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({Key? key}) : super(key: key);

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {

  final ScrollController featuredCommunitiesController = ScrollController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    final catalogProvider = Provider.of<CatalogProvider>(
      context,
      listen: false,
    );
    catalogProvider.gettingGuestCommunities(context, (model) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return MemorialAppBar(
      child: ValueListenableBuilder(
        valueListenable: accountProvider.user,
        builder: (context, data, _) {
          return FlowBuild(
            loadingFlow: UnScopeScaffold(
              body: ListView(
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
            ),
            activeFlow: UnScopeScaffold(
              backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
              body: ListView(
                physics: platformScrollPhysics(),
                children: [
                  authProvider.userRules == 'authorized' ?
                  Column(
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
                        child: TextFieldSearchWidget(
                          autofocus: false,
                          focusNode: searchFocusNode,
                          controller: catalogProvider.communityController,
                          hintText: 'Найдите сообщество и присоединяйтесь к нему',
                          onChanged: catalogProvider.activateMainCommunitiesFilter,
                          prefixIcon: catalogProvider.isCommunitySearch ?
                          Container(
                            height: 1.2.h,
                            width: 1.2.h,
                            margin: EdgeInsets.symmetric(
                              vertical: 1.2.h,
                              horizontal: 3.2.w,
                            ),
                            child: const LoadingIndicator(
                              indicatorType: Indicator.ballSpinFadeLoader,
                              colors: [
                                Color.fromRGBO(23, 94, 217, 1),
                              ],
                            ),
                          ) :
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 1.2.h,
                              horizontal: 3.2.w,
                            ),
                            child: Image.asset(
                              ConstantsAssets.searchImage,
                              height: 1.6.h,
                              width: 1.6.h,
                              color: searchFocusNode.hasFocus ||
                                  catalogProvider.communityController.text.isNotEmpty ?
                              const Color.fromRGBO(23, 94, 217, 1) :
                              const Color.fromRGBO(79, 79, 79, 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      catalogProvider.communitiesList.isNotEmpty ?
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
                              'Ваши сообщества',
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
                                    catalogProvider.setManagedCommunityList();
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => const CommunitiesUserSubscribedScreen(
                                          flowIs: 'Community',
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
                      catalogProvider.communitiesList.isEmpty ?
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 3.8.h,
                        ),
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        child: Column(
                          children: [
                            Image.asset(
                              ConstantsAssets.lackOfCommunitiesImage,
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
                              height: 0.6.h,
                            ),
                            Text(
                              'Create or add a community',
                              style: TextStyle(
                                fontFamily: ConstantsFonts.latoRegular,
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              height: 1.2.h,
                            ),
                            Container(
                              height: 5.h,
                              margin: EdgeInsets.symmetric(
                                horizontal: 26.w,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color.fromRGBO(23, 94, 217, 1),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () => Navigator.push(
                                    tabBarProvider.mainContext,
                                    CupertinoPageRoute(
                                      builder: (context) => const CreationFlow(
                                        checkFlow: CheckFlow.community,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+ CREATE COMMUNITY',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(23, 94, 217, 1),
                                        fontSize: 8.5.sp,
                                        fontFamily: ConstantsFonts.latoBold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ) :
                      Container(
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
                        child: catalogProvider.searchedCommunitiesList.isNotEmpty ?
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: catalogProvider.searchedCommunitiesList.isNotEmpty ?
                          catalogProvider.searchedCommunitiesList.length > 5 ?
                          5 :
                          catalogProvider.searchedCommunitiesList.length :
                          catalogProvider.communitiesList.length > 5 ?
                          5 :
                          catalogProvider.communitiesList.length,
                          itemBuilder: (context, index) {
                            // final dataList = catalogProvider.searchedCommunitiesList.isNotEmpty ?
                            // catalogProvider.searchedCommunitiesList[index] :
                            // catalogProvider.communitiesList[index];
                            final dataList = catalogProvider.communitiesList[index];
                            return HorizontalMiniCardWidget(
                              onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SelectedCommunityScreen(
                                    id: dataList.id ?? 0,
                                    avatar: dataList.avatar ?? '',
                                    banner: dataList.banner,
                                  ),
                                ),
                              ),
                              avatar: dataList.avatar ?? '',
                              title: dataList.title ?? '',
                              subtitle: dataList.subtitle ?? '',
                            );
                          },
                        ) :
                        const Center(
                          child: MemorialBookIconWidget(
                            title: 'Ничего не найдено...',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      if(catalogProvider.searchedFeaturedCommunitiesList.isNotEmpty)
                        HomeFrameWidget(
                          title: 'Избранные сообщества',
                          controller: featuredCommunitiesController,
                          widget: SizedBox(
                            height: 19.h,
                            child: ListView(
                              shrinkWrap: true,
                              controller: featuredCommunitiesController,
                              scrollDirection: Axis.horizontal,
                              physics: platformScrollPhysics(),
                              children: [
                                SizedBox(
                                  width: 3.2.w,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: catalogProvider.searchedFeaturedCommunitiesList.isNotEmpty ?
                                  catalogProvider.searchedFeaturedCommunitiesList.length :
                                  catalogProvider.featuredCommunitiesList.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    // final dataList = catalogProvider.searchedFeaturedCommunitiesList.isNotEmpty ?
                                    // catalogProvider.searchedFeaturedCommunitiesList[index] :
                                    // catalogProvider.featuredCommunitiesList[index];
                                    final dataList = catalogProvider.featuredCommunitiesList[index];
                                    return VerticalMiniCardWidget(
                                      onTap: () => Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => SelectedCommunityScreen(
                                            id: dataList.id ?? 0,
                                            avatar: dataList.avatar ?? '',
                                            banner: dataList.banner,
                                          ),
                                        ),
                                      ),
                                      title: dataList.title,
                                      subtitle: dataList.subtitle,
                                      avatar: dataList.avatar,
                                      banner: dataList.banner,
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 1.4.h,
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
                  ) :
                  Column(
                    children: [
                      SizedBox(
                        height: 1.2.h,
                      ),
                      HomeFrameWidget(
                        title: 'Избранные сообщества',
                        controller: featuredCommunitiesController,
                        widget: LimitedBox(
                          maxHeight: 19.h,
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
                                itemCount: catalogProvider.featuredCommunitiesList.length,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final dataList = catalogProvider.featuredCommunitiesList[index];
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => SelectedCommunityScreen(
                                          id: dataList.id ?? 0,
                                          avatar: dataList.avatar ?? '',
                                          banner: dataList.banner,
                                        ),
                                      ),
                                    ),
                                    child: VerticalMiniCardWidget(
                                      onTap: () => Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => SelectedCommunityScreen(
                                            id: dataList.id ?? 0,
                                            avatar: dataList.avatar ?? '',
                                            banner: dataList.banner,
                                          ),
                                        ),
                                      ),
                                      title: dataList.title,
                                      subtitle: dataList.subtitle,
                                      avatar: dataList.avatar,
                                      banner: dataList.banner,
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 1.4.h,
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
                              'A selection of communities',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: ConstantsFonts.latoBold,
                              ),
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
                          itemCount: catalogProvider.communitiesList.length,
                          itemBuilder: (context, index) {
                            final dataList = catalogProvider.communitiesList[index];
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => SelectedCommunityScreen(
                                      id: dataList.id ?? 0,
                                      avatar: dataList.avatar ?? '',
                                      banner: dataList.banner,
                                    ),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(50),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: dataList.avatar ?? '',
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
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(ConstantsAssets.memorialBookLogoImage),
                                            ),
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
                                      width: 3.w,
                                    ),
                                    SizedBox(
                                      width: 62.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            dataList.title ?? '',
                                            style: TextStyle(
                                              fontSize: 11.5.sp,
                                              fontFamily: ConstantsFonts.latoRegular,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.4.h,
                                          ),
                                          Text(
                                            dataList.subtitle ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 9.5.sp,
                                              fontFamily: ConstantsFonts.latoRegular,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                ],
              ),
              floatingActionButton: authProvider.userRules == 'authorized' ?
              Align(
                alignment: Alignment.bottomRight,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        tabBarProvider.mainContext,
                        CupertinoPageRoute(
                          builder: (context) => const CreationFlow(
                            checkFlow: CheckFlow.community,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(150),
                    child: Image.asset(
                      ConstantsAssets.bluePlusImage,
                      width: 10.w,
                    ),
                  ),
                ),
              ) :
              const SizedBox(),
            ),
            errorText: data?.message ?? 'Error',
          );
        },
      ),
    );
  }
}

