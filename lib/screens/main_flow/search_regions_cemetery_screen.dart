import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/catalog_provider.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/common/region_response_model.dart';
import '../../widgets/memorial_book_icon_widget.dart';
import '../../widgets/platform_scroll_physics.dart';

class SearchRegionsCemeteryScreen extends StatelessWidget {
  const SearchRegionsCemeteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    return MemorialAppBar(
      colorIcon: const Color.fromRGBO(18, 175, 82, 1),
      automaticallyImplyBackLeading: true,
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
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
              child: SearchEngine(
                focusNode: catalogProvider.searchedCemeteryRegionsFocusNode,
                controller: catalogProvider.searchedCemeteryRegionsController,
                autofocus: true,
                activeColor: const Color.fromRGBO(18, 175, 82, 1),
                isNotEmptyFunc: (name) async => await catalogProvider.searchRegionsCemetery(name),
                isEmptyFunc: () => catalogProvider.clearSearchedCemeteryRegionsData(),
                suffixIcon: catalogProvider.searchedCemeteryRegionsController.text.isNotEmpty ?
                PunchingAnimation(
                  child: GestureDetector(
                    onTap: () {
                      catalogProvider.clearSearchedCemeteryRegionsData();
                      FocusScope.of(context).unfocus();
                    },
                    child: Icon(
                      Icons.close,
                      size: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                ) : null,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            if(catalogProvider.searchedCemeteryRegionsModel != null && catalogProvider.searchedCemeteryRegionsModel!.regions!.isNotEmpty && catalogProvider.searchedCemeteryRegionsBool == false) Column(
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
                      'Найденные регионы',
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
                      final RegionResponseModel model = catalogProvider.searchedCemeteryRegionsModel!.regions![index];
                      return PunchingAnimation(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                            await catalogProvider.setSearchedRegionsCemetery(model.title ?? 'Регион');
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.2.h,
                            ),
                            child: Text(
                              model.title ?? 'Регион',
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                fontFamily: ConstantsFonts.latoRegular,
                                color: const Color.fromRGBO(32, 30, 31, 1),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: catalogProvider.searchedCemeteryRegionsModel?.regions?.length ?? 0,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Было найдено ${catalogProvider.searchedCemeteryRegionsModel?.regions?.length ?? 0} регионов',
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
            if(catalogProvider.searchedCemeteryRegionsModel != null && catalogProvider.searchedCemeteryRegionsModel!.regions!.isEmpty && catalogProvider.searchedCemeteryRegionsBool == false) const MemorialBookIconWidget(
              title: 'Ничего не найдено...',
              color: Color.fromRGBO(18, 175, 82, 1),
            ),
            if(catalogProvider.searchedCemeteryRegionsModel == null && catalogProvider.searchedCemeteryRegionsController.text.isEmpty && catalogProvider.searchedCemeteryRegionsBool == false) const MemorialBookIconWidget(
              title: 'Начните поиск',
              color: Color.fromRGBO(18, 175, 82, 1),
            ),
            if(catalogProvider.searchedCemeteryRegionsModel == null && catalogProvider.searchedCemeteryRegionsController.text.isNotEmpty && catalogProvider.searchedCemeteryRegionsBool == false) const MemorialBookIconWidget(
              title: 'Ошибка, пожалуйста, повторите попытку позже...',
              color: Color.fromRGBO(18, 175, 82, 1),
            ),
            if(catalogProvider.searchedCemeteryRegionsBool == true) Center(
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
                      Color.fromRGBO(18, 175, 82, 1),
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
