import 'package:flutter/cupertino.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/main_flow/search_regions_cemetery_screen.dart';
import 'package:memorial_book/widgets/chooser_widget.dart';
import 'package:memorial_book/widgets/main_button.dart';
import '../../widgets/animation/punching_animation.dart';
import '../../widgets/platform_scroll_physics.dart';
import '../../widgets/text_field_profile_widget.dart';
import '../../provider/catalog_provider.dart';
import '../../widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FilterPlaceScreen extends StatefulWidget {
  const FilterPlaceScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterPlaceScreen> createState() => _FilterPlaceScreenState();
}

class _FilterPlaceScreenState extends State<FilterPlaceScreen> {

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return UnScopeScaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SingleChildScrollView(
        physics: platformScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 8.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Поиск',
                style: TextStyle(
                  fontFamily: ConstantsFonts.latoBlack,
                  fontSize: 32.sp,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Название:',
                style: TextStyle(
                  color: const Color.fromRGBO(32, 30, 31, 0.5),
                  fontFamily: ConstantsFonts.latoRegular,
                  fontSize: 9.5.sp,
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: catalogProvider.placesController,
                onChanged: (text) => catalogProvider.updateState(),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Регион:',
                style: TextStyle(
                  color: const Color.fromRGBO(32, 30, 31, 0.5),
                  fontFamily: ConstantsFonts.latoRegular,
                  fontSize: 9.5.sp,
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromRGBO(205, 209, 214, 1),
                  ),
                  color: const Color.fromRGBO(245, 247, 249, 1),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.push(
                        tabBarProvider.mainContext,
                        CupertinoDialogRoute(
                          builder: (context) => const SearchRegionsCemeteryScreen(),
                          context: context,
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(1.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: platformScrollPhysics(),
                              child: Text(
                                catalogProvider.selectedRegion.isEmpty ?
                                'Регион' :
                                catalogProvider.selectedRegion,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: catalogProvider.selectedRegion.isEmpty ?
                                  const Color.fromRGBO(32, 30, 31, 0.5) :
                                  const Color.fromRGBO(32, 30, 31, 1),
                                  fontSize: 13.sp,
                                  fontFamily: ConstantsFonts.latoRegular,
                                ),
                              ),
                            ),
                          ),
                          catalogProvider.selectedRegion.isNotEmpty ?
                          PunchingAnimation(
                            child: GestureDetector(
                              onTap: () => catalogProvider.clearSearchedCemeteryRegionsData(),
                              child: Icon(
                                Icons.close,
                                size: 18.sp,
                                color: Colors.black,
                              ),
                            ),
                          ) :
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if(catalogProvider.selectedRegion.isNotEmpty) Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'Район:',
                    style: TextStyle(
                      color: const Color.fromRGBO(32, 30, 31, 0.5),
                      fontFamily: ConstantsFonts.latoRegular,
                      fontSize: 9.5.sp,
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  ChooserWidget(
                    tag: 'district',
                    list: catalogProvider.districtList,
                    text: catalogProvider.district,
                    condition: catalogProvider.districtCemeteryBool,
                    loadingColor: const Color.fromRGBO(18, 175, 82, 1),
                  ),
                ],
              ),
              SizedBox(
                height: 3.6.h,
              ),
              MainButton(
                condition: catalogProvider.placesController.text.length >= 3,
                text: 'ПОКАЗАТЬ',
                inactiveColor: const Color.fromRGBO(18, 175, 82, 0.6),
                activeColor: const Color.fromRGBO(18, 175, 82, 1),
                onTap: () {
                  catalogProvider.placeSearch();
                  Navigator.pop(context);
                },
                textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: ConstantsFonts.latoSemiBold,
                  fontSize: 9.5.sp,
                ),
              ),
              // AnimatedCrossFade(
              //   firstCurve: Curves.easeInBack,
              //   secondCurve: Curves.easeIn,
              //   duration: const Duration(
              //     milliseconds: 500,
              //   ),
              //   secondChild: const SizedBox(),
              //   firstChild: Container(
              //     decoration: filterProvider.advancedSettings != false ?
              //     BoxDecoration(
              //       color: const Color.fromRGBO(245, 247, 249, 1),
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(
              //         color: const Color.fromRGBO(205, 209, 214, 1),
              //       ),
              //     ) : null,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 16,
              //       vertical: 12,
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         filterProvider.advancedSettings != false ?
              //         GestureDetector(
              //           behavior: HitTestBehavior.translucent,
              //           onTap: () {
              //             filterProvider.switcherOfState();
              //           },
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(
              //                 'Advanced settings',
              //                 style: TextStyle(
              //                   fontSize: 13.sp,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 '(5 chosen)',
              //                 style: TextStyle(
              //                   color: const Color.fromRGBO(23, 94, 217, 1),
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 12.5.sp,
              //                 ),
              //               ),
              //               Image.asset(
              //                 ConstantsAssets.arrowBottomImage,
              //                 height: 0.8.h,
              //                 fit: BoxFit.fill,
              //               ),
              //             ],
              //           ),
              //         ) :
              //         GestureDetector(
              //           behavior: HitTestBehavior.translucent,
              //           onTap: () {
              //             filterProvider.switcherOfState();
              //           },
              //           child: Row(
              //             children: [
              //               Text(
              //                 'Advanced settings',
              //                 style: TextStyle(
              //                   fontSize: 13.sp,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //               const SizedBox(
              //                 width: 4,
              //               ),
              //               Image.asset(
              //                 ConstantsAssets.arrowBottomImage,
              //                 height: 0.8.h,
              //                 fit: BoxFit.fill,
              //               ),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 '(5 chosen)',
              //                 style: TextStyle(
              //                   color: const Color.fromRGBO(23, 94, 217, 1),
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 12.5.sp,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         filterProvider.advancedSettings != false ?
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             SizedBox(
              //               height: 6.h,
              //             ),
              //             Text(
              //               'Country',
              //               style: TextStyle(
              //                 color: Colors.grey.shade500,
              //                 fontSize: 10.sp,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //             TextFormField(
              //               style: TextStyle(
              //                 fontSize: 11.sp,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //               decoration: InputDecoration(
              //                 isDense: true,
              //                 filled: true,
              //                 contentPadding: const EdgeInsets.symmetric(
              //                   vertical: 5,
              //                 ),
              //                 fillColor: const Color.fromRGBO(245, 247, 249, 1),
              //                 hintStyle: TextStyle(
              //                   color: const Color.fromRGBO(158, 158, 158, 1),
              //                   fontSize: 10.sp,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 1.6.h,
              //             ),
              //             Text(
              //               'Cemetery',
              //               style: TextStyle(
              //                 color: Colors.grey.shade500,
              //                 fontSize: 10.sp,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //             SizedBox(
              //               height: 1.6.h,
              //             ),
              //             Wrap(
              //               children: listTiles.map(
              //                     (e) => Row(
              //                   mainAxisSize: MainAxisSize.min,
              //                   children: [
              //                     Text(
              //                       e['title'],
              //                       style: TextStyle(
              //                         fontWeight: FontWeight.w400,
              //                         fontSize: 13.sp,
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 4.w,
              //                     ),
              //                     Icon(
              //                       Icons.close,
              //                       size: 2.2.h,
              //                       color: Colors.black,
              //                     ),
              //                   ],
              //                 ),
              //               ).map(
              //                     (widget) => Container(
              //                       color: const Color.fromRGBO(255, 255, 255, 1),
              //                       padding: const EdgeInsets.only(
              //                         right: 14,
              //                         bottom: 5,
              //                         top: 5,
              //                         left: 14,
              //                       ),
              //                       margin: EdgeInsets.only(
              //                         right: 1.2.h,
              //                         bottom: 0.6.h,
              //                       ),
              //                       child: widget,
              //                     ),
              //               ).toList(),
              //             ),
              //             SizedBox(
              //               height: 1.6.h,
              //             ),
              //             TextFormField(
              //               style: TextStyle(
              //                 fontSize: 11.sp,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //               decoration: InputDecoration(
              //                 isDense: true,
              //                 filled: true,
              //                 contentPadding: const EdgeInsets.symmetric(
              //                   vertical: 5,
              //                 ),
              //                 fillColor: const Color.fromRGBO(245, 247, 249, 1),
              //                 hintStyle: TextStyle(
              //                   color: const Color.fromRGBO(158, 158, 158, 1),
              //                   fontSize: 10.sp,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ) :
              //         const SizedBox(),
              //       ],
              //     ),
              //   ),
              //   crossFadeState: CrossFadeState.showFirst,
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: EdgeInsets.only(
            top: 13.h,
          ),
          height: 6.4.h,
          width: 6.4.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: const Color.fromRGBO(229, 232, 235, 1),
              )
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(50),
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 2.4.h,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}