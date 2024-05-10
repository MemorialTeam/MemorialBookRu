import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/models/communitites/request/add_memorial_to_the_commnunity_request_model.dart';
import 'package:memorial_book/provider/catalog_provider.dart';
import 'package:memorial_book/screens/main_flow/adding_profiles_in_memorial_screen.dart';
import 'package:memorial_book/screens/main_flow/all_profiles_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/link_widget.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../helpers/constants.dart';
import '../provider/account_provider.dart';
import '../screens/main_flow/some_selected_screens/selected_people_screen.dart';
import '../test_data.dart';
import 'animation/animated_fade_out_in.dart';
import 'memorial_book_icon_widget.dart';
import 'switch_bar_items/cemetery_contacts.dart';
import 'cards/horizontal_mini_card_widget.dart';

enum CommunityOrCemeterySwitch {
  cemetery,
  community,
}
class SwitchBarWidget extends StatefulWidget {
  const SwitchBarWidget({
    Key? key,
    required this.switcher,
  }) : super(key: key);

  final CommunityOrCemeterySwitch switcher;

  @override
  State<SwitchBarWidget> createState() => _SwitchBarWidgetState();
}

class _SwitchBarWidgetState extends State<SwitchBarWidget> {

  final FocusNode cemeteryMemorialsNode = FocusNode();
  final FocusNode communityMemorialsNode = FocusNode();

  TextEditingController cemeteryMemorialsController = TextEditingController();
  TextEditingController communityMemorialsController = TextEditingController();

  int communitySearch = 1;
  int selectedMenuIndex = 0;

  Widget widgetSwitch(int index) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    if(widget.switcher == CommunityOrCemeterySwitch.cemetery) {
      final model = catalogProvider.selectedCemetery;
      switch(index) {
        case 0:
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Text(
              model.description ?? '',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade700,
              ),
            ),
          );
        case 1:
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.6.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchEngine(
                  focusNode: communityMemorialsNode,
                  controller: communityMemorialsController,
                  isNotEmptyFunc: (text) => catalogProvider.communityMemorialsSearch(text, model.id!),
                  isEmptyFunc: () => catalogProvider.gettingCommunityProfile(context, model.id ?? 0, (model) {}),
                  isSearching: catalogProvider.isMemorialsCommunitySearch,
                ),
                SizedBox(
                  height: 2.4.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final dataList = model.memorials?[index];
                    return HorizontalMiniCardWidget(
                      isAddingPeople: false,
                      onTap: () => accountProvider.gettingPeopleProfile(
                        context,
                        dataList?.id ?? 0,
                        ((model) {
                          if(model != null) {
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
                      ),
                      avatar: dataList?.avatar,
                      title: dataList?.fullName ?? '',
                      subtitle: '${dataList?.dateBirth.toString()} - ${dataList?.dateDeath.toString()}',
                      id: dataList?.id ?? 0,
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.memorials?.length != null && model.memorials!.length > 5 ?
                  5 :
                  model.memorials?.length ?? 0,
                ),
                SizedBox(
                  height: 2.4.h,
                ),
                model.memorials?.length != null && model.memorials!.length > 5 ?
                Container(
                  height: 6.4.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color.fromRGBO(245, 247, 249, 1),
                    border: Border.all(
                      color: const Color.fromRGBO(18, 175, 82, 1),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'SHOW MORE',
                      style: TextStyle(
                        color: Color.fromRGBO(18, 175, 82, 1),
                      ),
                    ),
                  ),
                ) :
                const SizedBox(),
              ],
            ),
          );
        case 2:
          return const CemeteryContacts();
        default:
          return const SizedBox();
      }
    }
    else if(widget.switcher == CommunityOrCemeterySwitch.community) {
      final selectedCommunityModel = catalogProvider.selectedCommunity;
      final memorialModel = catalogProvider.memorialDataModel;
      switch(index) {
        case 0:
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Text(
              selectedCommunityModel.description ?? '',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade700,
              ),
            ),
          );
        case 1:
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.6.w,
            ),
            child: memorialModel != null && memorialModel.data!.isNotEmpty ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchEngine(
                  focusNode: communityMemorialsNode,
                  controller: communityMemorialsController,
                  isNotEmptyFunc: (text) => catalogProvider.communityMemorialsSearch(communityMemorialsController.text, selectedCommunityModel.id!),
                  isEmptyFunc: () => catalogProvider.gettingMemorialsOfCommunity(
                    selectedCommunityModel.id ?? 0,
                    ((model) {}),
                  ),
                  isSearching: catalogProvider.isMemorialsCommunitySearch,

                ),
                SizedBox(
                  height: 1.8.h,
                ),
                selectedCommunityModel.isAdmin! ?
                GestureDetector(
                  onTap: () {
                    catalogProvider.disposeAddPeopleScreen();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const AddingProfilesInMemorialScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 1.8.h,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 4.w,
                        ),
                        Icon(
                          CupertinoIcons.plus,
                          size: 14.sp,
                          color: const Color.fromRGBO(23, 94, 217, 1),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          'Add profile to Memorial',
                          style: TextStyle(
                            fontFamily: ConstantsFonts.latoRegular,
                            fontSize: 10.5.sp,
                            color: const Color.fromRGBO(23, 94, 217, 1),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ) :
                const SizedBox(),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final dataList = memorialModel.data![index];
                    final String? firstName = dataList.firstName == '' || dataList.firstName == null ?
                    '' :
                    '${dataList.firstName} ';
                    final String? middleName = dataList.middleName == '' || dataList.middleName == null ?
                    '' :
                    '${dataList.middleName} ';
                    final String? lastName = dataList.lastName == '' || dataList.lastName == null ?
                    '' :
                    '${dataList.lastName}';
                    return Stack(
                      children: [
                        HorizontalMiniCardWidget(
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
                          avatar: dataList.avatar,
                          title: firstName! + middleName! + lastName!,
                          subtitle: '${dataList.dateBirth.toString()} - ${dataList.dateDeath.toString()}',
                          isAddingPeople: false,
                          id: dataList.id ?? 0,
                        ),
                        selectedCommunityModel.isAdmin! ?
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 4.w,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                print(dataList.id ?? 0);
                                // catalogProvider.removeMemorialFromTheCommunity(
                                //   context,
                                //   selectedCommunityModel.id ?? 0,
                                //   AddMemorialToTheCommunityRequestModel(
                                //     memorialId: dataList.id ?? 0,
                                //     memorialType: 'human',
                                //   ),
                                //   ((model) {
                                //
                                //   }),
                                // );
                              },
                              child: Icon(
                                Icons.remove_circle,
                                size: 22.sp,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ) :
                        const SizedBox(),
                      ],
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: memorialModel.data!.length >= 6 ?
                  6 :
                  memorialModel.data!.length,
                ),
                memorialModel.data!.length >= 7 ?
                Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    PunchingAnimation(
                      child: Container(
                        height: 6.4.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color.fromRGBO(245, 247, 249, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(23, 94, 217, 1),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async => await Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => AllProfilesScreen(
                                  communityId: selectedCommunityModel.id ?? 0,
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(7),
                            child: Center(
                              child: Text(
                                'SHOW MORE',
                                style: TextStyle(
                                  color: const Color.fromRGBO(23, 94, 217, 1),
                                  fontFamily: ConstantsFonts.latoBold,
                                  fontSize: 10.5.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ) :
                const SizedBox(),
              ],
            ) :
            GestureDetector(
              onTap: () {
                catalogProvider.disposeAddPeopleScreen();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AddingProfilesInMemorialScreen(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 1.8.h,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 4.w,
                    ),
                    Icon(
                      CupertinoIcons.plus,
                      size: 14.sp,
                      color: const Color.fromRGBO(23, 94, 217, 1),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Add profile to Memorial',
                      style: TextStyle(
                        fontFamily: ConstantsFonts.latoRegular,
                        fontSize: 10.5.sp,
                        color: const Color.fromRGBO(23, 94, 217, 1),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          // const MemorialBookIconWidget(
          //   title: 'There are no memorials in the community',
          //   color: Color.fromRGBO(23, 94, 217, 0.5),
          // )
        case 2:
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.4.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selectedCommunityModel.website != null ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Website',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontFamily: ConstantsFonts.latoSemiBold,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(
                      height: 2.4.h,
                    ),
                    LinkWidget(
                      link: selectedCommunityModel.website ?? '',
                    ),
                    SizedBox(
                      height: 2.4.h,
                    ),
                  ],
                ) :
                const SizedBox(),
                selectedCommunityModel.socialLinks != null ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Social',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontFamily: ConstantsFonts.latoSemiBold,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(
                      height: 2.4.h,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        String key = selectedCommunityModel.socialLinks?.keys.elementAt(index) ?? '';
                        final data = selectedCommunityModel.socialLinks?[key];
                        return LinkWidget(
                          link: data ?? '',
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 2.h,
                        );
                      },
                      itemCount: selectedCommunityModel.socialLinks?.length ?? 0,
                    ),
                  ],
                ) :
                const SizedBox(),
              ],
            ),
          );
          // return Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 3.2.w,
          //   ),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Flexible(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Row(
          //               children: [
          //                 Text(
          //                   'Products',
          //                   style: TextStyle(
          //                     color: const Color.fromRGBO(32, 30, 31, 1),
          //                     fontWeight: FontWeight.w700,
          //                     fontSize: 15.sp,
          //                     height: 0.115.h,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 2.w,
          //                 ),
          //                 Image.asset(
          //                   ConstantsAssets.iosArrowRightImage,
          //                   height: 1.45.h,
          //                 ),
          //               ],
          //             ),
          //             SizedBox(
          //               height: 1.8.h,
          //             ),
          //             GridView.builder(
          //               clipBehavior: Clip.none,
          //               itemCount: 10,
          //               shrinkWrap: true,
          //               physics: const NeverScrollableScrollPhysics(),
          //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: 2,
          //                 mainAxisExtent: 19.h,
          //                 mainAxisSpacing: 10,
          //                 crossAxisSpacing: 10,
          //               ),
          //               itemBuilder: (context, index) {
          //                 return Stack(
          //                   children: [
          //                     Container(
          //                       height: 19.h,
          //                       width: double.infinity,
          //                       decoration: BoxDecoration(
          //                         color: const Color.fromRGBO(225, 228, 231, 1),
          //                         borderRadius: BorderRadius.circular(8),
          //                       ),
          //                       child: Padding(
          //                         padding: EdgeInsets.symmetric(
          //                           horizontal: 1.2.h,
          //                           vertical: 0.6.h,
          //                         ),
          //                         child: Column(
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           mainAxisAlignment: MainAxisAlignment.end,
          //                           children: [
          //                             Text(
          //                               'Венки',
          //                               style: TextStyle(
          //                                 color: const Color.fromRGBO(32, 30, 31, 1),
          //                                 fontSize: 10.sp,
          //                                 fontWeight: FontWeight.w400,
          //                               ),
          //                             ),
          //                             SizedBox(
          //                               height: 0.4.h,
          //                             ),
          //                             Text(
          //                               'US \$29,99',
          //                               style: TextStyle(
          //                                 color: const Color.fromRGBO(32, 30, 31, 1),
          //                                 fontSize: 10.sp,
          //                                 fontWeight: FontWeight.w700,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     Container(
          //                       height: 13.h,
          //                       decoration: BoxDecoration(
          //                         color: const Color.fromRGBO(255, 255, 255, 1),
          //                         borderRadius: BorderRadius.circular(8),
          //                         image: DecorationImage(
          //                           image: AssetImage(ConstantsAssets.flowersImage),
          //                           fit: BoxFit.fill,
          //                         ),
          //                         boxShadow: const [
          //                           BoxShadow(
          //                             offset: Offset(0, 4),
          //                             blurRadius: 25,
          //                             spreadRadius: 0,
          //                             color: Color.fromRGBO(0, 0, 0, 0.03),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 );
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Row(
          //             children: [
          //               Text(
          //                 'Services',
          //                 style: TextStyle(
          //                   color: const Color.fromRGBO(32, 30, 31, 1),
          //                   fontWeight: FontWeight.w700,
          //                   fontSize: 15.sp,
          //                   height: 0.115.h,
          //                 ),
          //               ),
          //               SizedBox(
          //                 width: 2.w,
          //               ),
          //               Image.asset(
          //                 ConstantsAssets.iosArrowRightImage,
          //                 height: 1.45.h,
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 1.8.h,
          //           ),
          //           SizedBox(
          //             width: 130,
          //             child: GridView.builder(
          //               clipBehavior: Clip.none,
          //               itemCount: 5,
          //               shrinkWrap: true,
          //               physics: const NeverScrollableScrollPhysics(),
          //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: 1,
          //                 mainAxisExtent: 19.h,
          //                 mainAxisSpacing: 10,
          //                 crossAxisSpacing: 10,
          //               ),
          //               itemBuilder: (context, index) {
          //                 return Stack(
          //                   children: [
          //                     Container(
          //                       height: 19.h,
          //                       width: double.infinity,
          //                       decoration: BoxDecoration(
          //                         color: const Color.fromRGBO(225, 228, 231, 1),
          //                         borderRadius: BorderRadius.circular(8),
          //                       ),
          //                       child: Padding(
          //                         padding: EdgeInsets.symmetric(
          //                           horizontal: 1.2.h,
          //                           vertical: 0.6.h,
          //                         ),
          //                         child: Column(
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           mainAxisAlignment: MainAxisAlignment.end,
          //                           children: [
          //                             Text(
          //                               'Installing QR-code',
          //                               style: TextStyle(
          //                                 color: const Color.fromRGBO(32, 30, 31, 1),
          //                                 fontSize: 10.sp,
          //                                 fontWeight: FontWeight.w400,
          //                               ),
          //                             ),
          //                             SizedBox(
          //                               height: 0.4.h,
          //                             ),
          //                             Text(
          //                               'US \$29,99',
          //                               style: TextStyle(
          //                                 color: const Color.fromRGBO(32, 30, 31, 1),
          //                                 fontSize: 10.sp,
          //                                 fontWeight: FontWeight.w700,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     Container(
          //                       height: 13.h,
          //                       decoration: BoxDecoration(
          //                         color: const Color.fromRGBO(255, 255, 255, 1),
          //                         borderRadius: BorderRadius.circular(8),
          //                         image: DecorationImage(
          //                           image: AssetImage(
          //                             ConstantsAssets.tombstoneImage,
          //                           ),
          //                           fit: BoxFit.fill,
          //                         ),
          //                         boxShadow: const [
          //                           BoxShadow(
          //                             offset: Offset(0, 4),
          //                             blurRadius: 25,
          //                             spreadRadius: 0,
          //                             color: Color.fromRGBO(0, 0, 0, 0.03),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 );
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // );
        default:
          return const SizedBox();
      }
    }
    else {
      return const SizedBox();
    }
  }

  List menuItemSwitch() {
    switch(widget.switcher) {
      case CommunityOrCemeterySwitch.cemetery:
        final List menuItemsCemetery = TestData().menuOfCemetery;
        return menuItemsCemetery;
      case CommunityOrCemeterySwitch.community:
        final List menuItemsCommunity = TestData().menuOfCommunity;
        return menuItemsCommunity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2.4.h,
      ),
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.4.h,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  width: 2.7.w,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, indexMenu) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: indexMenu == selectedMenuIndex ?
                        const Color.fromRGBO(232, 239, 252, 1) :
                        Colors.transparent,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(35),
                          onTap: () {
                            setState(() => selectedMenuIndex = indexMenu);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.h,
                            ),
                            child: Center(
                              child: Text(
                                menuItemSwitch()[indexMenu],
                                style: indexMenu == 0 ?
                                TextStyle(
                                  color: const Color.fromRGBO(32, 30, 31, 0.8),
                                  fontFamily: ConstantsFonts.latoBold,
                                  fontSize: 11.5.sp,
                                ) :
                                TextStyle(
                                  color: const Color.fromRGBO(32, 30, 31, 0.8),
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 9.5.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 3.w,
                  ),
                  itemCount: menuItemSwitch().length,
                ),
                SizedBox(
                  width: 2.7.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          AnimatedFadeOutIn<int>(
            data: selectedMenuIndex,
            duration: const Duration(
              milliseconds: 200,
            ),
            builder: (value) => widgetSwitch(value),
          ),
        ],
      ),
    );

  }
}
