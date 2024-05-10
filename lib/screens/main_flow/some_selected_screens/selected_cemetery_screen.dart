import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/account_provider.dart';
import 'package:memorial_book/provider/auth_provider.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_community_screen.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_people_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/open_image_core.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../widgets/memorial_app_bar.dart';
import '../../../provider/catalog_provider.dart';
import '../../../widgets/cards/vertical_card_widget.dart';
import '../../../widgets/home_frame_widget.dart';
import '../../../widgets/switch_bar_widget.dart';

class SelectedCemeteryScreen extends StatefulWidget {
  const SelectedCemeteryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectedCemeteryScreen> createState() => _SelectedCemeteryScreenState();
}

class _SelectedCemeteryScreenState extends State<SelectedCemeteryScreen> {

  @override
  void initState() {
    final catalogProvider = Provider.of<CatalogProvider>(context, listen: false);
    catalogProvider.setMarkers();
    super.initState();
  }

  final ScrollController relatedProfilesController = ScrollController();

  bool loadingSub = false;

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final model = catalogProvider.selectedCemetery;

    return MemorialAppBar(
      colorIcon: const Color.fromRGBO(18, 175, 82, 1),
      automaticallyImplyBackLeading: true,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: SafeArea(
          child: Material(
            color: const Color.fromRGBO(245, 247, 249, 1),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  delegate: MySliverAppBar(
                    expandedHeight: 28.8.h,
                    image: model.avatar!,
                    backgroundImage: model.banner!,
                  ),
                  floating: false,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: EdgeInsets.only(
                        top: 7.h,
                        bottom: 1.6.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.h,
                            ),
                            child: Text(
                              model.title ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 19.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.6.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.h,
                            ),
                            child: Text(
                              model.subtitle ?? '',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 9.5.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.6.h,
                          ),
                          authProvider.userRules == 'authorized' ?
                          Column(
                            children: [
                              PunchingAnimation(
                                child: Container(
                                  height: 6.h,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 2.h,
                                  ),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: model.isSubscribe == true ?
                                    const Color.fromRGBO(250, 18, 46, 1) :
                                    const Color.fromRGBO(18, 175, 82, 1),
                                  ),
                                  child: GestureDetector(
                                    onTap: loadingSub == false ? () {
                                      loadingSub = true;
                                      setState(() {});
                                      if(model.isSubscribe == true) {
                                        catalogProvider.unsubscribeFromTheCemetery(model.id ?? 0, context, (model) {
                                          loadingSub = false;
                                          setState(() {});
                                        });
                                      } else {
                                        catalogProvider.subscribeToTheCemetery(model.id ?? 0, context, (model) {
                                          loadingSub = false;
                                          setState(() {});
                                        });
                                      }
                                    } :
                                    null,
                                    child: Center(
                                      child: loadingSub == false ?
                                      Text(
                                        model.isSubscribe == true ?
                                        'UNSUBSCRIBE' :
                                        'SUBSCRIBE',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.5.sp,
                                        ),
                                      ) :
                                      SizedBox(
                                        width: 4.h,
                                        height: 4.h,
                                        child: const LoadingIndicator(
                                          indicatorType: Indicator.ballSpinFadeLoader,
                                          colors: [
                                            Colors.white,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.6.h,
                              ),
                            ],
                          ) :
                          const SizedBox(),
                          model.gallery!.isNotEmpty ?
                          Column(
                            children: [
                              SizedBox(
                                height: 14.h,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    SizedBox(
                                      width: 2.h,
                                    ),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, indexMenu) {
                                        return OpenImage(
                                          initialIndex: indexMenu,
                                          disposeLevel: DisposeLevel.High,
                                          dataImage: model.gallery![indexMenu],
                                          child: CachedNetworkImage(
                                            imageUrl: model.gallery![indexMenu],
                                            imageBuilder: (context, imageProvider) {
                                              return Container(
                                                width: 14.h,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) => SizedBox(
                                        width: 3.w,
                                      ),
                                      itemCount: 1,
                                    ),
                                    SizedBox(
                                      width: 2.h,
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
                        ],
                      ),
                    ),
                    const SwitchBarWidget(
                      switcher: CommunityOrCemeterySwitch.cemetery,
                    ),
                    SizedBox(
                      height: 1.6.h,
                    ),
                    model.famousPersonalities != null && model.famousPersonalities!.isNotEmpty ?
                    HomeFrameWidget(
                      title: 'Famous personalities',
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
                              itemCount: model.famousPersonalities!.length,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final dataList = model.famousPersonalities![index];
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
                    ) :
                    const SizedBox(),
                  ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
