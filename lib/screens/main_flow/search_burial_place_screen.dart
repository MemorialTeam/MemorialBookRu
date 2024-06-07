import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/models/cemetery/response/search_cemetery_for_human_response_model.dart';
import 'package:memorial_book/provider/profile_creation_provider.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/memorial_book_icon_widget.dart';
import '../../widgets/platform_scroll_physics.dart';

class SearchBurialPlaceScreen extends StatelessWidget {
  const SearchBurialPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: UnScopeScaffold(
        body: ListView(
          physics: platformScrollPhysics(),
          children: [
            SizedBox(
              height: 1.h,
            ),
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              padding: EdgeInsets.symmetric(
                horizontal: 3.6.w,
                vertical: 1.h,
              ),
              child: Stack(
                children: [
                  SearchEngine(
                    focusNode: profileCreationProvider.searchCemeteryFocusNode,
                    controller: profileCreationProvider.searchCemeteryController,
                    isNotEmptyFunc: (name) async => await profileCreationProvider.searchCemeteryForHuman(name),
                    isEmptyFunc: () => profileCreationProvider.clearSearchedCemeteryData(),
                  ),
                  Positioned(
                    right: 2.w,
                    top: 0,
                    bottom: 0,
                    child: PunchingAnimation(
                      child: GestureDetector(
                        onTap: () {
                          profileCreationProvider.clearSearchedCemeteryData();
                          FocusScope.of(context).unfocus();
                        },
                        child: Icon(
                          Icons.close,
                          size: 20.sp,
                          color: const Color.fromRGBO(23, 94, 217, 1),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            if(profileCreationProvider.searchedCemeteryModel != null && profileCreationProvider.searchedCemeteryModel!.cemeteries!.isNotEmpty && profileCreationProvider.searchedCemeteryBool == false) Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.6.w,
                      vertical: 1.3.h,
                    ),
                    child: Text(
                      'Found cemeteries',
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        fontFamily: ConstantsFonts.latoSemiBold,
                        color: const Color.fromRGBO(32, 30, 31, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.1.h,
                ),
                Container(
                  width: double.infinity,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final CemeteryResponseModel model = profileCreationProvider.searchedCemeteryModel!.cemeteries![index];
                      return PunchingAnimation(
                        child: GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            await profileCreationProvider.setSearchedCemetery(model.name ?? 'Cemetery', model.address ?? 'No address', model.id ?? 0);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.2.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.name ?? 'Cemetery',
                                  style: TextStyle(
                                    fontSize: 11.5.sp,
                                    fontFamily: ConstantsFonts.latoRegular,
                                    color: const Color.fromRGBO(32, 30, 31, 1),
                                  ),
                                ),
                                Text(
                                  model.address ?? 'No address',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 9.5.sp,
                                    fontFamily: ConstantsFonts.latoRegular,
                                    color: const Color.fromRGBO(32, 30, 31, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: profileCreationProvider.searchedCemeteryModel!.cemeteries!.length,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  '${profileCreationProvider.searchedCemeteryModel!.total ?? 0} cemeteries were found',
                  style: TextStyle(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                    fontSize: 11.5.sp,
                    fontFamily: ConstantsFonts.latoRegular,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
            if(profileCreationProvider.searchedCemeteryModel != null && profileCreationProvider.searchedCemeteryModel!.cemeteries!.isEmpty && profileCreationProvider.searchedCemeteryBool == false) const MemorialBookIconWidget(
              title: 'Nothing was found...',
            ),
            if(profileCreationProvider.searchedCemeteryModel == null && profileCreationProvider.searchCemeteryController.text.isEmpty && profileCreationProvider.searchedCemeteryBool == false) const MemorialBookIconWidget(
              title: 'Start the search',
            ),
            if(profileCreationProvider.searchedCemeteryModel == null && profileCreationProvider.searchCemeteryController.text.isNotEmpty && profileCreationProvider.searchedCemeteryBool == false) const MemorialBookIconWidget(
              title: 'Error, please try again later...',
            ),
            if(profileCreationProvider.searchedCemeteryBool == true) Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 6.h,
                ),
                child: SizedBox(
                  height: 10.h,
                  width: 10.h,
                  child: const LoadingIndicator(
                    indicatorType: Indicator.ballRotateChase,
                    colors: [
                      Color.fromRGBO(23, 94, 217, 1)
                    ],
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
