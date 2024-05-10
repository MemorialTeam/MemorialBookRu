import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:memorial_book/helpers/constants.dart';
import '../../widgets/text_field_profile_widget.dart';
import '../../provider/catalog_provider.dart';
import '../../widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/enums.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    Key? key,
    required this.filterCheckFlow,
  }) : super(key: key);

  final MapFlowType filterCheckFlow;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    return UnScopeScaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 8.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoBlack,
                    fontSize: 32.sp,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Enter first name, middle name, last name of the profile you want to find. If you are not sure of the dates, specify approximate ones.',
                  style: TextStyle(
                    color: const Color.fromRGBO(32, 30, 31, 0.5),
                    fontFamily: ConstantsFonts.latoRegular,
                    fontSize: 10.5.sp,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                widget.filterCheckFlow == MapFlowType.people ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full name:',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                        fontSize: 9.5.sp,
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    TextFieldProfileWidget(
                      controller: catalogProvider.peopleController,
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Birth year:',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 9.5.sp,
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              TextFieldProfileWidget(
                                hintText: 'XXXX - XXXX г.',
                                inputFormatters: [
                                  // FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                  MaskedInputFormatter('####-####'),
                                ],
                                keyboardType: TextInputType.number,
                                controller: catalogProvider.birthYearController,
                                onChanged: (String text) {
                                  catalogProvider.errorChecking();
                                },
                                // borderColor: catalogProvider.checkBirth == true ?
                                // const Color.fromRGBO(250, 18, 46, 1) :
                                // null,
                              ),
                              // Column(
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     SizedBox(
                              //       height: 0.5.h,
                              //     ),
                              //     Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         Padding(
                              //           padding: EdgeInsets.symmetric(
                              //             horizontal: 1.2.w,
                              //           ),
                              //           child: Icon(
                              //             Icons.circle,
                              //             size: 5.sp,
                              //             color: catalogProvider.checkBirth == true ?
                              //             const Color.fromRGBO(250, 18, 46, 1) :
                              //             Colors.transparent,
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           width: 38.w,
                              //           child: Text(
                              //             catalogProvider.errorBirthYearsText,
                              //             style: TextStyle(
                              //               color: const Color.fromRGBO(250, 18, 46, 1),
                              //               fontFamily: ConstantsFonts.latoRegular,
                              //               fontSize: 8.5.sp,
                              //               height: 0.15.h,
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.6.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Death year:',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 9.5.sp,
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              TextFieldProfileWidget(
                                hintText: 'XXXX - XXXX г.',
                                inputFormatters: [
                                  // FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                  MaskedInputFormatter('#### ####'),
                                ],
                                keyboardType: TextInputType.number,
                                controller: catalogProvider.deathYearController,
                                onChanged: (String text) {
                                  catalogProvider.errorChecking();
                                },
                                // borderColor: catalogProvider.checkDeath == true ?
                                // const Color.fromRGBO(250, 18, 46, 1) :
                                // null,
                              ),
                              // Column(
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     SizedBox(
                              //       height: 0.5.h,
                              //     ),
                              //     Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         Padding(
                              //           padding: EdgeInsets.symmetric(
                              //             horizontal: 1.2.w,
                              //           ),
                              //           child: Icon(
                              //             Icons.circle,
                              //             size: 5.sp,
                              //             color: catalogProvider.checkDeath == true ?
                              //             const Color.fromRGBO(250, 18, 46, 1) :
                              //             Colors.transparent,
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           width: 38.w,
                              //           child: Text(
                              //             catalogProvider.errorDeathYearsText,
                              //             style: TextStyle(
                              //               color: const Color.fromRGBO(250, 18, 46, 1),
                              //               fontFamily: ConstantsFonts.latoRegular,
                              //               fontSize: 8.5.sp,
                              //               height: 0.15.h,
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 700,
                      ),
                      curve: Curves.ease,
                      height: catalogProvider.checkBirth == true || catalogProvider.checkDeath == true ?
                      2.h :
                      0,
                    ),
                    Text(
                      'Country:',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                        fontSize: 9.5.sp,
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    TextFieldProfileWidget(
                      controller: catalogProvider.countryController,
                    ),
                  ],
                ) :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                        fontSize: 9.5.sp,
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    TextFieldProfileWidget(
                      controller: catalogProvider.placesController,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.6.h,
                ),
                Container(
                  height: 6.8.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: catalogProvider.checkBirth == true || catalogProvider.checkDeath == true ?
                    widget.filterCheckFlow == MapFlowType.people ?
                    const Color.fromRGBO(23, 94, 217, 0.7) :
                    const Color.fromRGBO(18, 175, 82, 0.7) :
                    widget.filterCheckFlow == MapFlowType.people ?
                    const Color.fromRGBO(23, 94, 217, 1) :
                    const Color.fromRGBO(18, 175, 82, 1),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(7),
                      // onTap: catalogProvider.checkBirth == true || catalogProvider.checkDeath == true ?
                      // null : () {
                      //   catalogProvider.peopleSearch();
                      //   Navigator.pop(context);
                      // },
                      onTap: () {
                        catalogProvider.peopleSearch();
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Show',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.5.sp,
                          ),
                        ),
                      ),
                    ),
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
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 6.4.h,
          width: 6.4.h,
          margin: EdgeInsets.symmetric(
            vertical: 13.2.h,
          ),
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