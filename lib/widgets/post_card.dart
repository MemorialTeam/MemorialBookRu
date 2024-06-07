import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/models/common/determining_changes_post_data_model.dart';
import 'package:memorial_book/provider/catalog_provider.dart';
import 'package:memorial_book/provider/message_dialogs_provider.dart';
import 'package:memorial_book/provider/profile_creation_provider.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/main_flow/add_post_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/animation/vertical_soft_navigation.dart';
import 'package:memorial_book/widgets/platform_scroll_physics.dart';
import 'package:memorial_book/widgets/share_widget.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../helpers/enums.dart';
import '../models/communitites/response/get_community_info_response_model.dart';
import '../provider/onboarding_indicator_provider.dart';
import 'memorial_book_icon_widget.dart';
import 'open_image_core.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    Key? key,
    required this.model,
    required this.isAdmin,
    required this.communityId,
  }) : super(key: key);

  final PostsResponseModel model;
  final int communityId;
  final bool isAdmin;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  Widget typeFlow() {
    final onboardingIndicatorProvider = Provider.of<OnboardingIndicatorProvider>(context);
    switch(widget.model.contentType) {
      case PostContentType.textContent:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title ?? '',
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontFamily: ConstantsFonts.latoBold,
                      color: const Color.fromRGBO(32, 30, 31, 1),
                    ),
                  ),
                  SizedBox(
                    height: 0.6.h,
                  ),
                  Text(
                    widget.model.description ?? '',
                    style: TextStyle(
                      fontSize: 9.5.sp,
                      fontFamily: ConstantsFonts.latoRegular,
                      color: const Color.fromRGBO(32, 30, 31, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case PostContentType.mediaContent:
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 29.h,
              child: Stack(
                children: [
                  PageView.builder(
                    onPageChanged: (selected) {
                      widget.model.pageIndex = selected;
                      setState(() {});
                    },
                    controller: widget.model.pageController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return OpenImage(
                        initialIndex: index,
                        disposeLevel: DisposeLevel.High,
                        dataImage: widget.model.gallery ?? [],
                        imageUrl: 'url',
                        child: CachedNetworkImage(
                          imageUrl: widget.model.gallery?[index]['url'] ?? '',
                          progressIndicatorBuilder: (context, url, downloadProgress) => SkeletonLoaderWidget(
                            width: double.infinity,
                            height: 29.h,
                            borderRadius: 0,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                            width: double.infinity,
                            height: 29.h,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                ),
                                child: Text(
                                  'Got Error - $error',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: ConstantsFonts.latoBlack,
                                    fontSize: 12.5.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: double.infinity,
                              height: 29.h,
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
                    itemCount: widget.model.gallery?.length ?? 0,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.4.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.model.pageIndex != 0 ?
                          Container(
                            height: 4.6.h,
                            width: 4.6.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color.fromRGBO(229, 232, 235, 0.3),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  widget.model.pageController?.previousPage(
                                    duration: const Duration(
                                        milliseconds: 300
                                    ),
                                    curve: Curves.ease,
                                  );
                                },
                                borderRadius: BorderRadius.circular(7),
                                child: Center(
                                  child: Icon(
                                    Icons.chevron_left_outlined,
                                    size: 20.sp,
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                          ) :
                          const SizedBox(),
                          widget.model.pageIndex != widget.model.gallery!.length - 1 ?
                          Container(
                            height: 4.6.h,
                            width: 4.6.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color.fromRGBO(229, 232, 235, 0.3),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  widget.model.pageController?.nextPage(
                                    duration: const Duration(
                                        milliseconds: 300
                                    ),
                                    curve: Curves.ease,
                                  );
                                },
                                borderRadius: BorderRadius.circular(7),
                                child: Center(
                                  child: Icon(
                                    Icons.chevron_right_outlined,
                                    size: 20.sp,
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                          ) :
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 3.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: onboardingIndicatorProvider.buildGalleryPageIndicator(context, widget.model.pageIndex ?? 0, widget.model.gallery?.length ?? 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case PostContentType.textWithMediaContent:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 29.h,
              child: Stack(
                children: [
                  PageView.builder(
                    onPageChanged: (selected) {
                      widget.model.pageIndex = selected;
                      setState(() {});
                    },
                    controller: widget.model.pageController,
                    scrollDirection: Axis.horizontal,
                    physics: platformScrollPhysics(),
                    itemBuilder: (context, index) {
                      return OpenImage(
                        initialIndex: index,
                        disposeLevel: DisposeLevel.High,
                        dataImage: widget.model.gallery ?? [],
                        imageUrl: 'url',
                        child: CachedNetworkImage(
                          imageUrl: widget.model.gallery?[index]['url'].toString() ?? '',
                          progressIndicatorBuilder: (context, url, downloadProgress) => SkeletonLoaderWidget(
                            width: double.infinity,
                            height: 29.h,
                            borderRadius: 0,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                            width: double.infinity,
                            height: 29.h,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                ),
                                child: Text(
                                  'Got Error - $error',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: ConstantsFonts.latoBlack,
                                    fontSize: 12.5.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: double.infinity,
                              height: 29.h,
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
                    itemCount: widget.model.gallery?.length ?? 0,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.4.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.model.pageIndex != 0 ?
                          Container(
                            height: 4.6.h,
                            width: 4.6.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color.fromRGBO(229, 232, 235, 0.3),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  widget.model.pageController?.previousPage(
                                    duration: const Duration(
                                        milliseconds: 300
                                    ),
                                    curve: Curves.ease,
                                  );
                                },
                                borderRadius: BorderRadius.circular(7),
                                child: Center(
                                  child: Icon(
                                    Icons.chevron_left_outlined,
                                    size: 20.sp,
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                          ) :
                          const SizedBox(),
                          widget.model.pageIndex != widget.model.gallery!.length - 1 ?
                          Container(
                            height: 4.6.h,
                            width: 4.6.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color.fromRGBO(229, 232, 235, 0.3),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  widget.model.pageController?.nextPage(
                                    duration: const Duration(
                                        milliseconds: 300
                                    ),
                                    curve: Curves.ease,
                                  );
                                },
                                borderRadius: BorderRadius.circular(7),
                                child: Center(
                                  child: Icon(
                                    Icons.chevron_right_outlined,
                                    size: 20.sp,
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                          ) :
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 3.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: onboardingIndicatorProvider.buildGalleryPageIndicator(context, widget.model.pageIndex ?? 0, widget.model.gallery?.length ?? 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title ?? '',
                    style: TextStyle(
                      fontSize: 9.5.sp,
                      fontFamily: ConstantsFonts.latoRegular,
                      color: const Color.fromRGBO(32, 30, 31, 1),
                    ),
                  ),
                  SizedBox(
                    height: 1.8.h,
                  ),
                  Text(
                    widget.model.description ?? '',
                    style: TextStyle(
                      fontSize: 9.5.sp,
                      fontFamily: ConstantsFonts.latoRegular,
                      color: const Color.fromRGBO(32, 30, 31, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case PostContentType.none:
        return const MemorialBookIconWidget(
          title: 'The post is broken',
          color: Color.fromRGBO(23, 94, 217, 0.3),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    final messageDialogsProvider = Provider.of<MessageDialogsProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final catalogProvider = Provider.of<CatalogProvider>(context);
    return Container(
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
              children: [
                Row(
                  children: [
                    widget.model.author?.avatar != null && widget.model.author?.avatar != '' ?
                    CachedNetworkImage(
                      width: 6.2.h,
                      height: 6.2.h,
                      imageUrl: widget.model.author?.avatar ?? '',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 6.2.h,
                          height: 6.2.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                      progressIndicatorBuilder: (context, imageProvider, loading) {
                        return SkeletonLoaderWidget(
                          width: 6.2.h,
                          height: 6.2.h,
                          borderRadius: 150,
                        );
                      },
                    ) :
                    Container(
                      width: 6.2.h,
                      height: 6.2.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(ConstantsAssets.emptyAvatarImage),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.1.h,
                    ),
                    widget.model.publishedAt != null ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.model.author?.username ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                fontFamily: ConstantsFonts.latoBold,
                              ),
                            ),
                            widget.model.isPinned == true ?
                            Row(
                              children: [
                                SizedBox(
                                  width: 2.w,
                                ),
                                Image.asset(
                                  ConstantsAssets.pinnedImage,
                                  height: 1.2.h,
                                  width: 1.2.h,
                                  color: const Color.fromRGBO(130, 130, 130, 1),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  'Пост закреплён',
                                  style: TextStyle(
                                    fontSize: 7.5.sp,
                                    fontFamily: ConstantsFonts.latoRegular,
                                    color: const Color.fromRGBO(130, 130, 130, 1),
                                  ),
                                ),
                              ],
                            ) :
                            const SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          '${widget.model.publishedAt} y.',
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            fontFamily: ConstantsFonts.latoRegular,
                          ),
                        ),
                      ],
                    ) :
                    Row(
                      children: [
                        Text(
                          widget.model.author?.username ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            fontFamily: ConstantsFonts.latoBold,
                          ),
                        ),
                        widget.model.isPinned == true ?
                        Row(
                          children: [
                            SizedBox(
                              width: 2.w,
                            ),
                            Image.asset(
                              ConstantsAssets.pinnedImage,
                              height: 1.2.h,
                              width: 1.2.h,
                              color: const Color.fromRGBO(130, 130, 130, 1),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              'Пост закреплён',
                              style: TextStyle(
                                  fontSize: 7.5.sp,
                                  fontFamily: ConstantsFonts.latoRegular,
                                  color: const Color.fromRGBO(130, 130, 130, 1)
                              ),
                            ),
                          ],
                        ) :
                        const SizedBox(),
                      ],
                    ),
                  ],
                ),
                widget.isAdmin ?
                widget.model.contentType != PostContentType.none ?
                PopupMenuButton(
                  position: PopupMenuPosition.under,
                  constraints: BoxConstraints(
                    maxWidth: 42.w,
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
                      title: 'Редактировать',
                      image: Image.asset(
                        ConstantsAssets.editPostImage,
                        height: 1.8.h,
                      ),
                      weight: 2.8.w,
                      onTap: () {
                        profileCreationProvider.setEditPostState(
                          widget.model.contentType,
                          DeterminingChangesPostDataModel(
                            title: widget.model.title,
                            description: widget.model.description,
                            media: widget.model.gallery,
                          ),
                        );
                        Navigator.push(
                          tabBarProvider.mainContext,
                          verticalSoftNavigation(
                            AddPostScreen(
                              communityId: widget.communityId,
                              postType: PostType.editPost,
                              type: widget.model.contentType,
                              postId: widget.model.id,
                            ),
                          ),
                        );
                      },
                    ),
                    BoardTypePopupMenuItem(
                      title: 'Закрепить',
                      image: Image.asset(
                        ConstantsAssets.pinPostImage,
                        height: 1.65.h,
                      ),
                      weight: 3.8.w,
                      onTap: () async {
                        Navigator.pop(context);
                        await messageDialogsProvider.theSelectionWindow(
                          context: context,
                          title: 'Вы уверены, что хотите закрепить пост?',
                          yesButton: 'ДА',
                          noButton: 'Я ПЕРЕДУМАЛ',
                          yesOnTap: () async => await profileCreationProvider.pinPost(
                            widget.model.id ?? 0,
                            ((model) async {
                              if(model?.status == true) {
                                await catalogProvider.gettingPostsOfCommunity(catalogProvider.communityProfileModel?.id ?? 0);
                              }
                              await Navigator.maybePop(tabBarProvider.mainContext).whenComplete(() {
                                if(model?.status == false) {
                                  messageDialogsProvider.informationWindow(
                                    context: tabBarProvider.mainContext,
                                    title: model?.message ?? 'Что-то пошло не так',
                                    textButton: 'Закрыть',
                                  );
                                }
                              });
                            }),
                          ),
                          yesColorButton: const Color.fromRGBO(23, 94, 217, 1),
                        );
                      },
                    ),
                    BoardTypePopupMenuItem(
                      title: 'Удалить',
                      image: Image.asset(
                        ConstantsAssets.deletePostImage,
                        height: 2.h,
                      ),
                      weight: 4.w,
                      onTap: () async {
                        Navigator.pop(context);
                        await messageDialogsProvider.theSelectionWindow(
                          context: context,
                          title: 'Вы уверены, что хотите продолжить?',
                          subtitle: 'После удаления записи она больше не будет доступна.',
                          yesButton: 'УДАЛИТЬ ЗАПИСЬ',
                          noButton: 'Я ПЕРЕДУМАЛ',
                          yesOnTap: () async => await profileCreationProvider.deletePost(
                            widget.model.id ?? 0,
                            ((model) async {
                              if(model?.status == true) {
                                await catalogProvider.gettingPostsOfCommunity(catalogProvider.communityProfileModel?.id ?? 0);
                              }
                              await Navigator.maybePop(tabBarProvider.mainContext).whenComplete(() => messageDialogsProvider.informationWindow(
                                context: tabBarProvider.mainContext,
                                title: model?.status == true ?
                                'Пост успешно удален' :
                                model?.message ?? 'Что-то пошло не так',
                                textButton: 'Закрыть',
                              ));
                            }),
                          ),
                        );
                      },
                    ),
                  ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 1.4.h,
                    ),
                    child: Image.asset(
                      ConstantsAssets.settingsOfProfileImage,
                      width: 6.w,
                      height: 1.h,
                      color: const Color.fromRGBO(165, 165, 165, 1),
                    ),
                  ),
                ) :
                PunchingAnimation(
                  child: GestureDetector(
                    onTap: () async => await messageDialogsProvider.theSelectionWindow(
                        context: context,
                        title: 'Вы уверены, что хотите продолжить?',
                        subtitle: 'После удаления записи она больше не будет доступна.',
                        yesButton: 'УДАЛИТЬ ЗАПИСЬ',
                        noButton: 'Я ПЕРЕДУМАЛ',
                        yesOnTap: () async => await profileCreationProvider.deletePost(
                          widget.model.id ?? 0,
                          ((model) async {
                            if(model?.status == true) {
                              await catalogProvider.gettingPostsOfCommunity(catalogProvider.communityProfileModel?.id ?? 0);
                            }
                            await Navigator.maybePop(tabBarProvider.mainContext).whenComplete(() => messageDialogsProvider.informationWindow(
                              context: tabBarProvider.mainContext,
                              title: model?.status == true ?
                              'Пост успешно удален' :
                              model?.message ?? 'Что-то пошло не так',
                              textButton: 'Закрыть',
                            ));
                          }),
                        ),
                      ),
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 1.4.h,
                      ),
                      child: Image.asset(
                        ConstantsAssets.deletePostImage,
                        height: 2.4.h,
                        color: const Color.fromRGBO(165, 165, 165, 1),
                      ),
                    ),
                  ),
                ) :
                const SizedBox(),
              ],
            ),
          ),
          widget.model.contentType != PostContentType.none ?
          SizedBox(
            height: 1.6.h,
          ) :
          const SizedBox(),
          typeFlow(),
          widget.model.contentType != PostContentType.none ?
          Column(
            children: [
              SizedBox(
                height: 1.6.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.h,
                ),
                child: const ShareWidget(
                  shareText: '',
                ),
              ),
            ],
          ) :
          const SizedBox(),
        ],
      ),
    );
  }
}

enum MenuFlow {
  editPost,
  pinPost,
  deletePost,
}

class BoardTypePopupMenuItem extends PopupMenuEntry {
  const BoardTypePopupMenuItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
    required this.weight,
    this.style,
  });

  final void Function()? onTap;

  final String title;

  final Widget image;

  final double weight;

  final TextStyle? style;

  @override
  double get height => 5.6.h;

  @override
  State<StatefulWidget> createState() {
    return _BoardTypePopupMenuItemState();
  }

  @override
  bool represents(value) {
    throw UnimplementedError();
  }
}

class _BoardTypePopupMenuItemState
    extends State<BoardTypePopupMenuItem> {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        child: SizedBox(
          height: widget.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 3.8.w,
              ),
              widget.image,
              SizedBox(
                width: widget.weight,
              ),
              Text(
                widget.title,
                style: widget.style ?? TextStyle(
                  color: const Color.fromRGBO(51, 51, 51, 1),
                  fontFamily: ConstantsFonts.latoBold,
                  fontSize: 10.5.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}