import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/account_provider.dart';
import 'package:memorial_book/provider/profile_creation_provider.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/flow_build.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_cemetery_screen.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_community_screen.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_people_screen.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_pet_screen.dart';
import 'package:memorial_book/widgets/cards/vertical_card_widget.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/home_frame_skeleton_widget.dart';
import 'package:memorial_book/widgets/home_frame_widget.dart';
import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_core.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../provider/auth_provider.dart';
import '../../provider/catalog_provider.dart';
import '../../widgets/animation/punching_animation.dart';
import '../../widgets/cards/vertical_mini_card_widget.dart';
import '../../widgets/skeleton_loader_widget.dart';
import '../profile_creation_flow/creation_flow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ScrollController relatedProfilesController = ScrollController();
  ScrollController cemeteryController = ScrollController();
  ScrollController celebrityPetsController = ScrollController();
  ScrollController celebrityHumansController = ScrollController();
  ScrollController communitiesController = ScrollController();

  @override
  void initState() {
    final _catalogProvider = Provider.of<CatalogProvider>(context, listen: false);
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _catalogProvider.setCustomMarker();
    if(_authProvider.userRules == 'authorized') {
      _catalogProvider.gettingAuthorizedMainContent(context, (model) {});
    } else if(_authProvider.userRules == 'guest') {
      _catalogProvider.gettingGuestMainContent(context, (model) {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    return MemorialAppBar(
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: accountProvider.user,
            builder: (context, data, _) => FlowBuild(
              loadingFlow: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 1.2.h,
                  ),
                  HomeFrameSkeletonWidget(
                    width: 32,
                    widget: LimitedBox(
                      maxHeight: 26.h,
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
                                width: 28.w,
                                borderRadius: 5,
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                width: 10,
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
                  HomeFrameSkeletonWidget(
                    width: 21,
                    widget: LimitedBox(
                      maxHeight: 19.h,
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
                              return const SizedBox(
                                width: 10,
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
                  HomeFrameSkeletonWidget(
                    width: 28,
                    widget: LimitedBox(
                      maxHeight: 26.h,
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
                                width: 28.w,
                                borderRadius: 5,
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                width: 10,
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
                ],
              ),
              activeFlow: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 1.2.h,
                  ),
                  HomeFrameWidget(
                    title: authProvider.userRules == 'authorized' ?
                    'Связанные профили' :
                    'Люди',
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
                            itemCount: catalogProvider.humans.length,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final dataList = catalogProvider.humans[index];
                              final String? firstName = dataList.firstName == '' || dataList.firstName == null ?
                              '' :
                              '${dataList.firstName} ';
                              final String? lastName = dataList.lastName == '' || dataList.lastName == null ?
                              '' :
                              '${dataList.lastName}';
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
                                subtitle: '${dataList.yearBirth} - ${dataList.yearDeath} y.',
                                title: firstName! + lastName!,
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
                            width: catalogProvider.humans.isNotEmpty ?
                            3.2.w :
                            0,
                          ),
                          authProvider.userRules == 'authorized' ?
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PunchingAnimation(
                                child: SizedBox(
                                  width: 28.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      profileCreationProvider.disposeHumanCreate();
                                      Navigator.push(
                                        tabBarProvider.mainContext,
                                        CupertinoPageRoute(
                                          builder: (context) => const CreationFlow(
                                            checkFlow: CheckFlow.profile,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 18.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: const Color.fromRGBO(241, 241, 241, 1),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              CupertinoIcons.plus,
                                              color: const Color.fromRGBO(130, 130, 130, 1),
                                              size: 20.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.2.h,
                                        ),
                                        Text(
                                          'Создать профиль',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 9.5.sp,
                                            fontFamily: ConstantsFonts.latoBold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ) ,
                              SizedBox(
                                width: 3.2.w,
                              ),
                            ],
                          ) :
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  HomeFrameWidget(
                    title: 'Кладбище',
                    controller: cemeteryController,
                    widget: SizedBox(
                      height: 19.h,
                      child: ListView(
                        controller: cemeteryController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            width: 3.2.w,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: catalogProvider.cemeteries.length,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final dataList = catalogProvider.cemeteries[index];
                              return VerticalMiniCardWidget(
                                onTap: () {
                                  catalogProvider.gettingCemeteryProfile(context, dataList.id ?? 0, (model) {
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
                                title: dataList.title,
                                subtitle: dataList.subtitle,
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
                            width: catalogProvider.cemeteries.isNotEmpty ?
                            3.2.w :
                            0,
                          ),
                          authProvider.userRules == 'authorized' ?
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 19.h,
                                width: 42.w,
                                child: PunchingAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      tabBarProvider.selectTab(TabItem.places);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromRGBO(244, 247, 250, 1),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: Container(
                                              height: 9.h,
                                              width: 42.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: const Color.fromRGBO(244, 247, 250, 1),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 2.2.w,
                                                  vertical: 1.2.h,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Найдите кладбище',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9.5.sp,
                                                        fontFamily: ConstantsFonts.latoBold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 0.5.h,
                                                    ),
                                                    Text(
                                                      '',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9.5.sp,
                                                        fontFamily: ConstantsFonts.latoBold,
                                                        color: const Color.fromRGBO(32, 30, 31, 0.6),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 11.5.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: const Color.fromRGBO(229, 232, 235, 1),
                                            ),
                                          ),
                                          Positioned(
                                            top: 7.4.h,
                                            left: 1.h,
                                            child: Container(
                                              width: 5.4.h,
                                              height: 5.4.h,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(255, 255, 255, 1),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  CupertinoIcons.plus,
                                                  color: const Color.fromRGBO(130, 130, 130, 1),
                                                  size: 20.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.2.w,
                              ),
                            ],
                          ) :
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  HomeFrameWidget(
                    title: 'Питомцы',
                    controller: celebrityPetsController,
                    widget: LimitedBox(
                      maxHeight: 26.h,
                      child: ListView(
                        controller: celebrityPetsController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            width: 3.2.w,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: catalogProvider.pets.length,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final dataList = catalogProvider.pets[index];
                              return GestureDetector(
                                onTap: () {
                                  accountProvider.gettingPetProfile(context, dataList.id ?? 0, (model) {
                                    if(model!.status == true) {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => SelectedPetScreen(
                                            model: model,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CachedNetworkImage(
                                      width: 28.w,
                                      height: 18.3.h,
                                      imageUrl: dataList.avatar ?? '',
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          width: 28.w,
                                          height: 18.3.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                      errorWidget: (context, error, _) {
                                        return Container(
                                          width: 28.w,
                                          height: 18.3.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: AssetImage(ConstantsAssets.memorialBookLogoImage),
                                            ),
                                          ),
                                        );
                                      },
                                      progressIndicatorBuilder: (context, url, downloadProgress) {
                                        return SkeletonLoaderWidget(
                                          width: 28.w,
                                          height: 18.3.h,
                                          borderRadius: 5,
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 1.4.h,
                                    ),
                                    Text(
                                      '${dataList.yearBirth} - ${dataList.yearDeath} y.',
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        fontFamily: ConstantsFonts.latoRegular,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.6.h,
                                    ),
                                    Text(
                                      dataList.name ?? '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontFamily: ConstantsFonts.latoBold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 3.w,
                              );
                            },
                          ),
                          SizedBox(
                            width: catalogProvider.pets.isNotEmpty ?
                            3.2.w :
                            0,
                          ),

                          authProvider.userRules == 'authorized' ?
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  profileCreationProvider.disposePetCreate();
                                  Navigator.push(
                                    tabBarProvider.mainContext,
                                    CupertinoPageRoute(
                                      builder: (context) => const CreationFlow(
                                        checkFlow: CheckFlow.pet,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 28.w,
                                      height: 18.3.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromRGBO(241, 241, 241, 1),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.plus,
                                          color: const Color.fromRGBO(130, 130, 130, 1),
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      'Создайте профиль\nпитомца',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontFamily: ConstantsFonts.latoBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 3.2.w,
                              ),
                            ],
                          ) :
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  HomeFrameWidget(
                    title: 'Сообщества',
                    controller: communitiesController,
                    widget: SizedBox(
                      height: 19.h,
                      child: ListView(
                        controller: communitiesController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            width: 3.2.w,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: catalogProvider.communities.length,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final dataList = catalogProvider.communities[index];
                              return VerticalMiniCardWidget(
                                onTap: () {
                                  catalogProvider.gettingCommunityProfile(context, dataList.id ?? 0, (model) {
                                    if(model!.status == true) {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => const SelectedCommunityScreen(),
                                        ),
                                      );
                                    }
                                  });
                                },
                                title: dataList.title,
                                subtitle: dataList.subtitle,
                                avatar: dataList.avatar,
                                banner: dataList.banner,
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 3.2.w,
                              );
                            },
                          ),
                          SizedBox(
                            width: catalogProvider.communities.isNotEmpty ?
                            3.2.w :
                            0,
                          ),

                          authProvider.userRules == 'authorized' ?
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 41.w,
                                child: PunchingAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      tabBarProvider.selectTab(TabItem.communities);
                                    },
                                    child: Container(
                                      height: 19.5.h,
                                      width: 42.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromRGBO(244, 247, 250, 1),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: Container(
                                              height: 9.h,
                                              width: 42.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: const Color.fromRGBO(244, 247, 250, 1),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 2.2.w,
                                                  vertical: 1.2.h,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Найдите сообщества',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9.5.sp,
                                                        fontFamily: ConstantsFonts.latoBold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 0.5.h,
                                                    ),
                                                    Text(
                                                      '',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 9.5.sp,
                                                        fontFamily: ConstantsFonts.latoBold,
                                                        color: const Color.fromRGBO(32, 30, 31, 0.6),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 11.5.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: const Color.fromRGBO(229, 232, 235, 1),
                                            ),
                                          ),
                                          Positioned(
                                            top: 7.4.h,
                                            left: 1.h,
                                            child: Container(
                                              width: 5.4.h,
                                              height: 5.4.h,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(255, 255, 255, 1),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  CupertinoIcons.plus,
                                                  color: const Color.fromRGBO(130, 130, 130, 1),
                                                  size: 20.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.2.w,
                              ),
                            ],
                          ) :
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  /// future
                  // SizedBox(
                  //   height: 3.4.h,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 16,
                  //   ),
                  //   child: Text(
                  //     'News line',
                  //     style: TextStyle(
                  //       color: Colors.grey.shade500,
                  //       fontSize: 18.sp,
                  //       fontFamily: ConstantsFonts.latoRegular,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 1.2.h,
                  // ),
                  // ListView.separated(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return NewsMisesWidget(
                  //       dataParsing: tagsList[index],
                  //     );
                  //   },
                  //   separatorBuilder: (context, index) {
                  //     return SizedBox(
                  //       height: 1.2.h,
                  //     );
                  //   },
                  //   itemCount: tagsList.length,
                  // ),
                ],
              ),
              errorText: data?.message ?? 'Error',
            ),
          ),
        ),
      ),
    );
  }
}