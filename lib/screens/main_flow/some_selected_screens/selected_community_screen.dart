import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/helpers/enums.dart';
import 'package:memorial_book/models/common/community_edit_model.dart';
import 'package:memorial_book/provider/profile_creation_provider.dart';
import 'package:memorial_book/screens/main_flow/add_post_screen.dart';
import 'package:memorial_book/screens/main_flow/all_pictures_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/animation/vertical_soft_navigation.dart';
import 'package:memorial_book/widgets/boot_engine.dart';
import 'package:memorial_book/widgets/platform_scroll_physics.dart';
import 'package:memorial_book/widgets/post_card.dart';
import 'package:memorial_book/widgets/switch_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/catalog_provider.dart';
import '../../../provider/tab_bar_provider.dart';
import '../../../widgets/element_selection/body_type_popup_menu_item.dart';
import '../../../widgets/full_screen_gallery.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/memorial_app_bar.dart';
import '../../../widgets/skeleton_loader_widget.dart';
import '../../../widgets/unscope_scaffold.dart';
import '../../profile_creation_flow/creation_flow.dart';

class SelectedCommunityScreen extends StatefulWidget {
  const SelectedCommunityScreen({
    Key? key,
    required this.id,
    required this.avatar,
  }) : super(key: key);

  final String avatar;
  final int id;

  @override
  State<SelectedCommunityScreen> createState() => _SelectedCommunityScreenState();
}

class _SelectedCommunityScreenState extends State<SelectedCommunityScreen> {

  @override
  void initState() {
    final catalogProvider = Provider.of<CatalogProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_)  {
      catalogProvider.gettingCommunityProfile(context, widget.id);
    });
    super.initState();
  }

  bool loadingSub = false;

  Widget subscribeButton() {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final model = catalogProvider.communityProfileModel;

    return MainButton(
      activeColor: model?.isSubscribe == true ?
      const Color.fromRGBO(250, 18, 46, 1) :
      const Color.fromRGBO(23, 94, 217, 1),
      onTap: loadingSub == false ?
      (() async {
        setState(() => loadingSub = true);
        if(model?.isSubscribe == true) {
          await catalogProvider.unsubscribeFromTheCommunity(
            model?.id ?? 0,
            context,
            ((model) => setState(() => loadingSub = false)),
          );
        } else {
          await catalogProvider.subscribeToTheCommunity(
            model?.id ?? 0,
            context,
            ((model) => setState(() => loadingSub = false)),
          );
        }
      }) :
      (() {}),
      child: Center(
        child: loadingSub == false ?
        Text(
          model?.isSubscribe == true ?
          'ОТПИСАТЬСЯ' :
          'ПОДПИСАТЬСЯ',
          style: TextStyle(
            color: Colors.white,
            fontFamily: ConstantsFonts.latoRegular,
            fontSize: 9.5.sp,
          ),
        ) :
        SizedBox(
          height: 2.67.h,
          width: 2.67.h,
          child: const LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            colors: [
              Colors.white,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    final model = catalogProvider.communityProfileModel;
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        floatingActionButton: model?.isAdmin == true ?
        Align(
          alignment: Alignment.bottomRight,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                profileCreationProvider.disposeAddPostScreen();
                Navigator.push(
                  tabBarProvider.mainContext,
                  verticalSoftNavigation(
                    AddPostScreen(
                      communityId: model?.id ?? 0,
                      postType: PostType.addPost,
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
         null,
        body: BootEngine(
          loadValue: catalogProvider.getCommunityProfileState,
          activeFlow: CustomScrollView(
            physics: platformScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                delegate: MySliverAppBar(
                  expandedHeight: 28.8.h,
                  image: model?.avatar ?? '',
                  backgroundImage: model?.banner ?? '',
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
                          Text(
                            model?.title ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 19.sp,
                            ),
                          ),
                          SizedBox(
                            height: 1.6.h,
                          ),
                          Text(
                            model?.subtitle ?? '',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 9.5.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 1.6.h,
                              ),
                              if(authProvider.userRules == 'authorized')
                                Column(
                                  children: [
                                    model?.isAdmin == true ?
                                    Row(
                                      children: [
                                        Flexible(
                                          child: MainButton(
                                            onTap: () {
                                              profileCreationProvider.disposeAddPostScreen();
                                              Navigator.push(
                                                tabBarProvider.mainContext,
                                                verticalSoftNavigation(
                                                  AddPostScreen(
                                                    communityId: model?.id ?? 0,
                                                    postType: PostType.addPost,
                                                  ),
                                                ),
                                              );
                                            },
                                            text: 'ДОБАВИТЬ ПОСТ',
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontFamily: ConstantsFonts.latoRegular,
                                              fontSize: 9.5.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        PunchingAnimation(
                                          child: PopupMenuButton(
                                            position: PopupMenuPosition.under,
                                            constraints: BoxConstraints(
                                              maxWidth: 45.w,
                                            ),
                                            surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
                                            color: const Color.fromRGBO(255, 255, 255, 1),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              ),
                                            ),
                                            itemBuilder: ((context) => [
                                              BoardTypePopupMenuItem(
                                                title: 'Изменить данные',
                                                image: Image.asset(
                                                  ConstantsAssets.editPostImage,
                                                  height: 1.8.h,
                                                ),
                                                weight: 2.8.w,
                                                onTap: () {
                                                  profileCreationProvider.setEditCommunityState(model!);
                                                  profileCreationProvider.uploadingDataToControllers(
                                                    CommunityEditModel(
                                                      avatar: model.avatar,
                                                      banner: model.banner,
                                                      title: model.title ?? '',
                                                      subtitle: model.subtitle ?? '',
                                                      address: model.address ?? '',
                                                      email: model.email ?? '',
                                                      phone: model.phone ?? '',
                                                      website: model.website ?? '',
                                                      description: model.description ?? '',
                                                      id: model.id ?? 0,
                                                    ),
                                                  );
                                                  Navigator.push(
                                                    tabBarProvider.mainContext,
                                                    CupertinoPageRoute(
                                                      builder: (context) => const CreationFlow(
                                                        checkFlow: CheckFlow.editCommunity,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              BoardTypePopupMenuItem(
                                                title: 'Поделиться',
                                                image: Image.asset(
                                                  ConstantsAssets.shareCommunityImage,
                                                  height: 1.65.h,
                                                ),
                                                weight: 3.8.w,
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  await Share.share('Do you love your loved ones? Download the app to keep in touch with your departed loved ones - https://memorialbook.site/api/v1/feed');
                                                },
                                              ),
                                            ]),
                                            child: Container(
                                              height: 5.5.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(7),
                                                color: const Color.fromRGBO(229, 232, 235, 1),
                                              ),
                                              padding: EdgeInsets.only(
                                                right: 4.w,
                                                left: 4.w,
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  ConstantsAssets.threePointsImage,
                                                  width: 5.2.w,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ) :
                                    subscribeButton(),
                                    SizedBox(
                                      height: 1.6.h,
                                    ),
                                  ],
                                ),
                              Row(
                                children: [
                                  Text(
                                    'Подписчики: ${model?.subscribersCount}',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(32, 30, 31, 0.7),
                                      fontSize: 11.5.sp,
                                      fontFamily: ConstantsFonts.latoBold,
                                      height: 0.15.h,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.6.h,
                                  ),
                                  if(model?.lastSubscribers != null)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(model!.lastSubscribers!.length < 6 ?
                                      model.lastSubscribers!.length :
                                      6, (index) {
                                        final dataList = model.lastSubscribers![index];
                                        return GestureDetector(
                                          onTap: () => Navigator.push,
                                          child: CachedNetworkImage(
                                            imageUrl: dataList.avatar ?? '',
                                            imageBuilder: (context, imageProvider) {
                                              return SizedBox(
                                                height: 4.6.h,
                                                width: 7.5.w,
                                                child: OverflowBox(
                                                  maxWidth: 12.w,
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    height: 5.5.h,
                                                    width: 5.5.h,
                                                    padding: EdgeInsets.all(0.2.h),
                                                    child: Container(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            placeholder: (context, indicator) {
                                              return SizedBox(
                                                height: 4.6.h,
                                                width: 7.5.w,
                                                child: OverflowBox(
                                                  maxWidth: 60,
                                                  child: SkeletonLoaderWidget(
                                                    height: 5.5.h,
                                                    width: 5.5.h,
                                                    borderRadius: 50,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorWidget: (context, error, _) {
                                              return SizedBox(
                                                height: 4.6.h,
                                                width: 7.5.w,
                                                child: OverflowBox(
                                                  maxWidth: 12.w,
                                                  child: SkeletonLoaderWidget(
                                                    height: 5.5.h,
                                                    width: 5.5.h,
                                                    borderRadius: 50,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SwitchBarWidget(
                      switcher: CommunityOrCemeterySwitch.community,
                    ),
                    SizedBox(
                      height: 1.6.h,
                    ),
                    model?.gallery != null && model!.gallery!.isNotEmpty ?
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.6.h,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(229, 232, 235, 1),
                              ),
                              top: BorderSide(
                                color: Color.fromRGBO(229, 232, 235, 1),
                              ),
                            ),
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 2.h,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Картинки',
                                      style: TextStyle(
                                        fontFamily: ConstantsFonts.latoBold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        Navigator.push(
                                          tabBarProvider.mainContext,
                                          verticalSoftNavigation(
                                            AllPicturesScreen(
                                              imagesList: model.gallery ?? [],
                                              galleryTitle: model.title ?? '',
                                            ),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: 3.9.h,
                                        child: Text(
                                          'Все',
                                          style: TextStyle(
                                            fontFamily: ConstantsFonts.latoRegular,
                                            fontSize: 11.5.sp,
                                            color: tabBarProvider.currentTab != TabItem.places ? const Color.fromRGBO(23, 94, 217, 1) : const Color.fromRGBO(18, 175, 82, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              SizedBox(
                                height: 15.h,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: platformScrollPhysics(),
                                  children: [
                                    SizedBox(
                                      width: 2.h,
                                    ),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, indexMenu) {
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                            tabBarProvider.mainContext,
                                            PageRouteBuilder(
                                              opaque: false,
                                              barrierColor: Colors.black.withOpacity(0.4),
                                              pageBuilder: (BuildContext context, _, __) => FullScreenGallery(
                                                title: model.title ?? '',
                                                galleryModels: model.gallery,
                                                initialIndex: indexMenu,
                                              ),
                                            ),
                                          ),
                                          child: Hero(
                                            tag: indexMenu,
                                            child: CachedNetworkImage(
                                              imageUrl: model.gallery![indexMenu].url ?? '',
                                              imageBuilder: (context, imageProvider) {
                                                return Container(
                                                  width: 15.h,
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
                                                  width: 15.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 2.5.w,
                                                      ),
                                                      child: Text(
                                                        'Got Error - $error',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: ConstantsFonts.latoBlack,
                                                          fontSize: 9.5.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) => SizedBox(
                                        width: 1.w,
                                      ),
                                      itemCount: model.gallery!.length,
                                    ),
                                    SizedBox(
                                      width: 2.h,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.6.h,
                        ),

                      ],
                    ) :
                    const SizedBox(),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final postModel = catalogProvider.postsDataModel!.data![index];
                        return PostCard(
                          model: postModel,
                          isAdmin: model?.isAdmin ?? false,
                          communityId: model?.id ?? 0,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 1.6.h,
                        );
                      },
                      itemCount: catalogProvider.postsDataModel?.data != null ?
                      catalogProvider.postsDataModel!.data!.length :
                      0,
                    ),
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

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  MySliverAppBar({
    required this.expandedHeight,
    required this.image,
    required this.backgroundImage,
    this.emoji,
    this.paddingEmoji,
  });

  final double expandedHeight;
  final String image;
  final String backgroundImage;
  final String? emoji;
  final EdgeInsetsGeometry? paddingEmoji;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        backgroundImage != '' ?
        CachedNetworkImage(
          imageUrl: backgroundImage,
          imageBuilder: (context, imageProvider) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          errorWidget: (context, error, widget) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ConstantsAssets.memorialBookLogoImage),
                ),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return const SkeletonLoaderWidget(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 0,
            );
          },
        ) :
        const SizedBox(),
        Positioned(
          top: expandedHeight / 2.14 - shrinkOffset,
          left: 5.5.w,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Stack(
              children: [
                image != '' ?
                CachedNetworkImage(
                  imageUrl: image,
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
                ) :
                Container(
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
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 40.sp,
                      color: const Color.fromRGBO(186, 186, 186, 1),
                    ),
                  ),
                ),
                emoji != null && emoji != '' ?
                Positioned(
                  bottom: 0.h,
                  right: 1.6.h,
                  child: Container(
                    height: 4.4.h,
                    width: 4.4.h,
                    padding: paddingEmoji ?? EdgeInsets.all(0.4.h),
                    alignment: Alignment.bottomRight,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Image.asset(
                      emoji!,
                    ),
                  ),
                ) :
                const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}