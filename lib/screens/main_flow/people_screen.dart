import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/enums.dart';
import 'package:memorial_book/screens/flow_build.dart';
import 'package:memorial_book/screens/loading_screens/map_loading_screen.dart';
import 'package:memorial_book/screens/main_flow/filter_people_screen.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_people_screen.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/cards/horizontal_mini_card_widget.dart';
import 'package:memorial_book/widgets/memorial_book_icon_widget.dart';
import 'package:memorial_book/widgets/platform_scroll_physics.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../provider/account_provider.dart';
import '../../provider/catalog_provider.dart';
import '../../widgets/map_ui/search_header_widget.dart';

class PeopleScreen extends StatelessWidget {
  PeopleScreen({Key? key}) : super(key: key);

  final FocusNode searchFocusNode = FocusNode();

  final double maxChildSizeSheet = 1.0;

  final DraggableScrollableController sheetController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    return MemorialAppBar(
      child: UnScopeScaffold(
        backgroundColor: Colors.white,
        body: ValueListenableBuilder(
          valueListenable: accountProvider.user,
          builder: (context, data, _) => FlowBuild(
            loadingFlow: const MapLoadingScreen(),
            activeFlow: CustomScrollView(
              physics: platformScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 7.6.h,
                  leading: const SizedBox(),
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
                  floating: true,
                  flexibleSpace: SearchHeaderWidget(
                    focusNode: searchFocusNode,
                    onSearch: (text) async => await catalogProvider.peopleSearch(),
                    controller: catalogProvider.peopleController,
                    filterRoute: const FilterPeopleScreen(),
                    context: context,
                    filterCount: catalogProvider.countEnabledParameters(MapFlowType.people).toString(),
                    mainColor: const Color.fromRGBO(23, 94, 217, 1),
                  ),
                ),
                SliverToBoxAdapter(
                  child: catalogProvider.peopleListLoading == false ?
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if(catalogProvider.countEnabledParameters(MapFlowType.people) != 0 && catalogProvider.peoples!.isEmpty) {
                        return const MemorialBookIconWidget(
                          title: 'Ничего не найдено',
                        );
                      } else if(catalogProvider.countEnabledParameters(MapFlowType.people) == 0 && catalogProvider.peoples!.isEmpty) {
                        return const MemorialBookIconWidget(
                          title: 'MemorialBook',
                        );
                      }
                      else {
                        final dataList = catalogProvider.peoples![index];
                        final String firstName = dataList.firstName == '' || dataList.firstName == null ?
                        '' :
                        '${dataList.firstName} ';
                        final String middleName = dataList.middleName == '' || dataList.middleName == null ?
                        '' :
                        '${dataList.middleName} ';
                        final String lastName = dataList.lastName == '' || dataList.lastName == null ?
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
                          isVerified: dataList.isCelebrity,
                          avatar: dataList.avatar,
                          title: firstName+ middleName+ lastName,
                          subtitle: '${dataList.dateBirth.toString()} - ${dataList.dateDeath.toString()}',
                          id: dataList.id ?? 0,
                        );
                      }
                    },
                    itemCount: catalogProvider.peoples!.isNotEmpty ?
                    catalogProvider.peoples!.length :
                    1,
                  ) :
                  SizedBox(
                    width: 7.h,
                    height: 7.h,
                    child: const LoadingIndicator(
                      indicatorType: Indicator.ballPulse,
                      colors: [
                        Color.fromRGBO(23, 94, 217, 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            errorText: data?.message ?? 'Error',
          ),
        ),
      ),
    );
  }
}