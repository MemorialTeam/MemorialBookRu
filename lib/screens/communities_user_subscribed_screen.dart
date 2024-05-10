import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/screens/profile_creation_flow/creation_flow.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../helpers/constants.dart';
import '../models/communitites/response/get_community_info_response_model.dart';
import '../provider/catalog_provider.dart';
import '../provider/tab_bar_provider.dart';
import '../widgets/memorial_app_bar.dart';
import '../widgets/cards/horizontal_mini_card_widget.dart';
import '../widgets/memorial_book_icon_widget.dart';
import '../widgets/text_field_search_widget.dart';
import 'main_flow/some_selected_screens/selected_cemetery_screen.dart';
import 'main_flow/some_selected_screens/selected_community_screen.dart';

class CommunitiesUserSubscribedScreen extends StatelessWidget {
  const CommunitiesUserSubscribedScreen({
    Key? key,
    required this.flowIs,
  }) : super(key: key);

  final String flowIs;

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      colorIcon: flowIs == 'Community' ?
      const Color.fromRGBO(23, 94, 217, 1) :
      const Color.fromRGBO(18, 175, 82, 1),
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 1.2.h,
                ),
                // widget.flowIs == 'Cemetery' ?
                // Container(
                //   height: 9.h,
                //   color: const Color.fromRGBO(255, 255, 255, 1),
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 3.2.w,
                //     vertical: 1.2.h,
                //   ),
                //   child: TextFieldSearchWidget(
                //     autofocus: false,
                //     focNode: focusNodes[0],
                //     controller: catalogProvider.cemeteryController,
                //     hintText: 'Find and join a cemetery',
                //     onChanged: (String value) {
                //       if(value.isNotEmpty) {
                //         if(i % 3 == 0) {
                //           catalogProvider.cemeterySearch();
                //         }
                //         i++;
                //       }
                //       else {
                //         catalogProvider.gettingCemetery(context, (model) {});
                //       }
                //     },
                //     prefixIcon: catalogProvider.isCemeterySearch ?
                //     Container(
                //       margin: EdgeInsets.symmetric(
                //         vertical: 1.2.h,
                //         horizontal: 3.2.w,
                //       ),
                //       child: const LoadingIndicator(
                //         indicatorType: Indicator.ballSpinFadeLoader,
                //         colors: [
                //           Color.fromRGBO(18, 175, 82, 1),
                //         ],
                //       ),
                //     ) :
                //     Container(
                //       margin: EdgeInsets.symmetric(
                //         vertical: 1.2.h,
                //         horizontal: 3.2.w,
                //       ),
                //       child: Image.asset(
                //         ConstantsAssets.searchImage,
                //         height: 1.6.h,
                //         width: 1.6.h,
                //         color: focusNodes[0].hasFocus ||
                //             catalogProvider.cemeteryController.text.isNotEmpty ?
                //         const Color.fromRGBO(18, 175, 82, 1) :
                //         const Color.fromRGBO(79, 79, 79, 1),
                //       ),
                //     ),
                //   ),
                // ) :
                // const SizedBox(),
                // widget.flowIs == 'Community' ?
                // Container(
                //   height: 9.h,
                //   color: const Color.fromRGBO(255, 255, 255, 1),
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 16,
                //     vertical: 10,
                //   ),
                //   child: TextFieldSearchWidget(
                //     autofocus: false,
                //     focNode: searchNode,
                //     controller: TextEditingController(),
                //     hintText: 'Find and join a community',
                //     prefixIcon: Container(
                //       margin: const EdgeInsets.symmetric(
                //         vertical: 10,
                //         horizontal: 13,
                //       ),
                //       child: Image.asset(
                //         ConstantsAssets.searchImage,
                //         height: 14,
                //         width: 14,
                //         color: searchNode.hasFocus || searchController.text.isNotEmpty ?
                //         const Color.fromRGBO(18, 175, 82, 1) :
                //         const Color.fromRGBO(79, 79, 79, 1),
                //       ),
                //     ),
                //   ),
                // ) :
                // const SizedBox(),
                Container(
                  height: 9.h,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: TextFieldSearchWidget(
                    onChanged: (value) => catalogProvider.toSortCommunitiesFollowList(value),
                    autofocus: false,
                    focusNode: catalogProvider.searchFollowNode,
                    controller: catalogProvider.searchFollowController,
                    hintText: flowIs == 'Community' ?
                    'Find and join a community' :
                    'Find and join a cemetery',
                    prefixIcon: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 13,
                      ),
                      child: Image.asset(
                        ConstantsAssets.searchImage,
                        height: 14,
                        width: 14,
                        color: catalogProvider.searchFollowNode.hasFocus || catalogProvider.searchFollowController.text.isNotEmpty ?
                        const Color.fromRGBO(23, 94, 217, 1) :
                        const Color.fromRGBO(79, 79, 79, 1),
                      ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        flowIs == 'Community' ?
                        'All communities' :
                        'All cemeteries',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: ConstantsFonts.latoBold,
                        ),
                      ),
                      PunchingAnimation(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => catalogProvider.switchStateCommunityManage(),
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                              height: 3.4.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: catalogProvider.isCommunitiesManaged == true ?
                                const Color.fromRGBO(229, 232, 235, 1) :
                                Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Managed',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(79, 79, 79, 1),
                                    fontSize: 9.5.sp,
                                    fontFamily: ConstantsFonts.latoRegular,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: catalogProvider.communitiesFollowList().isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: flowIs == 'Community' ?
                    catalogProvider.communitiesFollowList().length :
                    catalogProvider.cemeteryList.length,
                    itemBuilder: (context, index) {
                      if(flowIs == 'Community') {
                        CommunitiesInfoResponseModel dataList = catalogProvider.communitiesFollowList()[index];
                        return HorizontalMiniCardWidget(
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
                          avatar: dataList.avatar ?? '',
                          title: dataList.title ?? '',
                          subtitle: dataList.subtitle ?? '',
                        );
                      }
                      else {
                        final dataList = catalogProvider.cemeteryList[index];
                        return HorizontalMiniCardWidget(
                          onTap: () {
                            catalogProvider.gettingCemeteryProfile(context, dataList.id ?? 0, (model) {
                              if(model!.status == true) {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const SelectedCemeteryScreen(),
                                  ),
                                );
                              }
                            });
                          },
                          avatar: dataList.avatar ?? '',
                          title: dataList.title ?? '',
                          subtitle: dataList.subtitle ?? '',
                        );
                      }
                    },
                  ) :
                  const MemorialBookIconWidget(
                    title: 'Nothing found',
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 2.4.h,
                right: 3.4.w,
              ),
              child: Align(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
