import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/provider/auth_provider.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_community_screen.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_people_screen.dart';
import 'package:memorial_book/widgets/boot_engine.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../widgets/memorial_app_bar.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/enums.dart';
import '../../../provider/catalog_provider.dart';
import '../../../widgets/cards/vertical_card_widget.dart';
import '../../../widgets/full_screen_gallery.dart';
import '../../../widgets/home_frame_widget.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/platform_scroll_physics.dart';
import '../../../widgets/skeleton_loader_widget.dart';
import '../../../widgets/switch_bar_widget.dart';

class SelectedCemeteryScreen extends StatefulWidget {
  const SelectedCemeteryScreen({
    Key? key,
    required this.avatar,
    required this.id,
  }) : super(key: key);

  final String avatar;
  final int id;

  @override
  State<SelectedCemeteryScreen> createState() => _SelectedCemeteryScreenState();
}

class _SelectedCemeteryScreenState extends State<SelectedCemeteryScreen> {

  @override
  void initState() {
    final catalogProvider = Provider.of<CatalogProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await catalogProvider.gettingCemeteryProfile(context, widget.id);
    });
    super.initState();
  }

  final ScrollController relatedProfilesController = ScrollController();

  bool loadingSub = false;

  Widget subscribeButton() {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final model = catalogProvider.cemeteryProfileModel;
    return MainButton(
      activeColor: model?.isSubscribe == true ?
      const Color.fromRGBO(250, 18, 46, 1) :
      const Color.fromRGBO(18, 175, 82, 1),
      onTap: loadingSub == false ?
      (() async {
        setState(() => loadingSub = true);
        if(model?.isSubscribe == true) {
          await catalogProvider.unsubscribeFromTheCemetery(
            model?.id ?? 0,
            context,
            ((model) => setState(() => loadingSub = false)),
          );
        } else {
          await catalogProvider.subscribeToTheCemetery(
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
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final model = catalogProvider.cemeteryProfileModel;
    return MemorialAppBar(
      colorIcon: const Color.fromRGBO(18, 175, 82, 1),
      automaticallyImplyBackLeading: true,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: SafeArea(
          child: Material(
            color: const Color.fromRGBO(245, 247, 249, 1),
            child: BootEngine(
              loadValue: catalogProvider.getCemeteryProfileState,
              activeFlow: CustomScrollView(
                physics: platformScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(
                      expandedHeight: 28.8.h,
                      image: model?.avatar ?? '',
                      backgroundImage: model?.banner  ?? '',
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
                                model?.name ?? '',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoBlack,
                                  fontSize: 21.sp,
                                  height: 0.9.sp,
                                ),
                              ),
                              SizedBox(
                                height: 1.6.h,
                              ),
                              Text(
                                model?.description ?? '',
                                style: TextStyle(
                                  color: const Color.fromRGBO(32, 30, 31, 0.8),
                                  fontSize: 9.5.sp,
                                  fontFamily: ConstantsFonts.latoRegular,
                                ),
                              ),
                              SizedBox(
                                height: 1.6.h,
                              ),
                              if(authProvider.userRules == 'authorized') Padding(
                                padding: EdgeInsets.only(
                                  bottom: 1.6.h,
                                ),
                                child: subscribeButton(),
                              ),
                            ],
                          ),
                        ),
                        if(model?.gallery != null && model!.gallery!.isNotEmpty)
                          Column(
                            children: [
                              SizedBox(
                                height: 14.h,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: platformScrollPhysics(),
                                  children: [
                                    SizedBox(
                                      width: 3.w,
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
                                                title: model.name ?? '',
                                                galleryModels: model.gallery,
                                                initialIndex: indexMenu,
                                              ),
                                            ),
                                          ),
                                          child: Hero(
                                            tag: indexMenu,
                                            child: CachedNetworkImage(
                                              imageUrl: model.gallery![indexMenu].url!,
                                              imageBuilder: (context, imageProvider) {
                                                return Container(
                                                  width: 15.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
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
                                      width: 3.w,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.6.h,
                              ),
                            ],
                          ),
                        const SwitchBarWidget(
                          switcher: CommunityOrCemeterySwitch.cemetery,
                        ),
                        SizedBox(
                          height: 1.6.h,
                        ),
                        model?.famousPersonalities != null && model!.famousPersonalities!.isNotEmpty ?
                        HomeFrameWidget(
                          title: 'Известные личности',
                          controller: relatedProfilesController,
                          widget: SizedBox(
                            height: 26.5.h,
                            child: ListView(
                              controller: relatedProfilesController,
                              scrollDirection: Axis.horizontal,
                              physics: platformScrollPhysics(),
                              children: [
                                SizedBox(
                                  width: 2.2.w,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: model.famousPersonalities!.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final dataList = model.famousPersonalities![index];
                                    final String firstName = dataList.firstName == '' || dataList.firstName == null ?
                                    '' :
                                    '${dataList.firstName} ';
                                    final String lastName = dataList.lastName == '' || dataList.lastName == null ?
                                    '' :
                                    '${dataList.lastName}';
                                    return VerticalCardWidget(
                                      onTap: () => Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => SelectedPeopleScreen(
                                            avatar: dataList.avatar ?? '',
                                            id: dataList.id ?? 0,
                                          ),
                                        ),
                                      ),
                                      subtitle: '${dataList.yearBirth} - ${dataList.yearDeath} y.',
                                      title: firstName + lastName,
                                      avatar: dataList.avatar,
                                      isCelebrity: dataList.isCelebrity ?? false,
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 3.w,
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 2.2.w,
                                ),
                              ],
                            ),
                          ),
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
