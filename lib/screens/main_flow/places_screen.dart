import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/screens/flow_build.dart';
import 'package:memorial_book/screens/loading_screens/map_loading_screen.dart';
import 'package:memorial_book/screens/main_flow/filter_place_screen.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../helpers/enums.dart';
import '../../provider/account_provider.dart';
import '../../provider/catalog_provider.dart';
import '../../provider/tab_bar_provider.dart';
import '../../widgets/map_ui/frame_of_map.dart';
import '../../widgets/maps_places_card_widget.dart';
import '../../widgets/memorial_book_icon_widget.dart';

class PlacesScreen extends StatelessWidget {
  PlacesScreen({Key? key}) : super(key: key);

  final FocusNode searchFocusNode = FocusNode();

  final double maxChildSizeSheet = 1.0;

  // final double maxChildSizeSheet = 0.112.h;
  final DraggableScrollableController sheetController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    return MemorialAppBar(
      colorIcon: const Color.fromRGBO(18, 175, 82, 1),
      child: SafeArea(
        child: UnScopeScaffold(
          body: ValueListenableBuilder(
            valueListenable: accountProvider.user,
            builder: (context, data, _) => FlowBuild(
              loadingFlow: const MapLoadingScreen(),
              activeFlow: FrameOfMap(
                onMapCreated: catalogProvider.onMapPlacesCreated,
                markers: catalogProvider.markersPlaces.values,
                mapFlowType: MapFlowType.places,
                geoLoadValue: catalogProvider.geoPlaceLoader,
                sheetLoadValue: catalogProvider.placeListLoading,
                geoIcon: ConstantsAssets.geoPlacesLocatorImage,
                mainColor: const Color.fromRGBO(18, 175, 82, 1),
                mapsScrollableSheetBuilder: (BuildContext context, int index) {
                  if(catalogProvider.countEnabledParameters(MapFlowType.places) != 0 && catalogProvider.places!.isEmpty) {
                    return const MemorialBookIconWidget(
                      title: 'Nothing found',
                      color: Color.fromRGBO(18, 175, 82, 0.3),
                    );
                  }
                  else if(catalogProvider.countEnabledParameters(MapFlowType.places) == 0 && catalogProvider.places!.isEmpty) {
                    return const MemorialBookIconWidget(
                      title: 'MemorialBook',
                      color: Color.fromRGBO(18, 175, 82, 0.3),
                    );
                  }
                  else {
                    final dataList = catalogProvider.places![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.2.w,
                      ),
                      child: MapsPlacesCardWidget(
                        model: dataList,
                      ),
                    );
                  }
                },
                sheetController: sheetController,
                childSizeSheet: maxChildSizeSheet,
                searchFocusNode: searchFocusNode,
                onSearch: (text) async => await catalogProvider.placeSearch(),
                searchController: catalogProvider.placesController,
                filterCount: catalogProvider.countEnabledParameters(MapFlowType.places).toString(),
                context: tabBarProvider.mainContext,
                filterRoute: const FilterPlaceScreen(),
                total: catalogProvider.mapPlacesTotal,
                dataList: catalogProvider.places!,
              ),
              errorText: data?.message ?? 'Error',
            ),
          ),
        ),
      ),
    );
  }
}