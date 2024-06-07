import 'package:flutter/cupertino.dart';
import 'package:memorial_book/helpers/enums.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/flow_build.dart';
import 'package:memorial_book/screens/loading_screens/map_loading_screen.dart';
import 'package:memorial_book/screens/main_flow/filter_people_screen.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_people_screen.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/cards/horizontal_mini_card_widget.dart';
import 'package:memorial_book/widgets/map_ui/frame_of_map.dart';
import 'package:memorial_book/widgets/memorial_book_icon_widget.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import '../../helpers/constants.dart';
import '../../provider/account_provider.dart';
import '../../provider/catalog_provider.dart';

class PeopleScreen extends StatelessWidget {
  PeopleScreen({Key? key}) : super(key: key);

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
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: ValueListenableBuilder(
          valueListenable: accountProvider.user,
          builder: (context, data, _)  => FlowBuild(
            loadingFlow: const MapLoadingScreen(),
            activeFlow: FrameOfMap(
              onMapCreated: catalogProvider.onMapPeopleCreated,
              markers: catalogProvider.peopleMarkers.values,
              mapFlowType: MapFlowType.people,
              geoLoadValue: catalogProvider.geoPeopleLoader,
              sheetLoadValue: catalogProvider.peopleListLoading,
              geoIcon: ConstantsAssets.geoPeopleLocatorImage,
              mainColor: const Color.fromRGBO(23, 94, 217, 1),
              mapsScrollableSheetBuilder: (BuildContext context, int index) {
                if(catalogProvider.countEnabledParameters(MapFlowType.people) != 0 && catalogProvider.peoples!.isEmpty) {
                  return const MemorialBookIconWidget(
                    title: 'Nothing found',
                  );
                } else if(catalogProvider.countEnabledParameters(MapFlowType.people) == 0 && catalogProvider.peoples!.isEmpty) {
                  return const MemorialBookIconWidget(
                    title: 'MemorialBook',
                  );
                }
                else {
                  final dataList = catalogProvider.peoples![index];
                  final String? firstName = dataList.firstName == '' || dataList.firstName == null ?
                  '' :
                  '${dataList.firstName} ';
                  final String? middleName = dataList.middleName == '' || dataList.middleName == null ?
                  '' :
                  '${dataList.middleName} ';
                  final String? lastName = dataList.lastName == '' || dataList.lastName == null ?
                  '' :
                  '${dataList.lastName}';
                  return HorizontalMiniCardWidget(
                    isAddingPeople: false,
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SelectedPeopleScreen(
                          avatar: dataList.avatar ?? '',
                          id: dataList.id ?? 0,
                        ),
                      ),
                    ),
                    avatar: dataList.avatar,
                    title: firstName! + middleName! + lastName!,
                    subtitle: '${dataList.dateBirth.toString()} - ${dataList.dateDeath.toString()}',
                    id: dataList.id ?? 0,
                  );
                }
              },
              sheetController: sheetController,
              childSizeSheet: maxChildSizeSheet,
              searchFocusNode: searchFocusNode,
              onSearch: (text) async => await catalogProvider.peopleSearch(),
              searchController: catalogProvider.peopleController,
              filterCount: catalogProvider.countEnabledParameters(MapFlowType.people).toString(),
              context: tabBarProvider.mainContext,
              filterRoute: const FilterScreen(
                filterCheckFlow: MapFlowType.people,
              ),
              dataList: catalogProvider.peoples!,
              total: catalogProvider.mapPeoplesTotal,
            ),
            errorText: data?.message ?? 'Error',
          ),
        ),
      ),
    );
  }
}