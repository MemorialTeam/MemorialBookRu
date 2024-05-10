import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_people_screen.dart';
import '../../widgets/cards/horizontal_mini_card_widget.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import '../../widgets/memorial_book_icon_widget.dart';
import '../../provider/account_provider.dart';
import '../../provider/catalog_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddingProfilesInMemorialScreen extends StatelessWidget {
  const AddingProfilesInMemorialScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final catalogProvider = Provider.of<CatalogProvider>(context);
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 1.2.h,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 3.2.w,
                vertical: 1.2.h,
              ),
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: SearchEngine(
                focusNode: catalogProvider.addPeopleFocusNode,
                controller: catalogProvider.addPeopleController,
                isNotEmptyFunc: (text) => catalogProvider.addToCommunityPeopleSearch(),
                isEmptyFunc: () => catalogProvider.clearAddPeopleFoundPeoples(),
              ),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if(catalogProvider.addPeopleFoundPeoples.isEmpty &&
                    catalogProvider.addPeopleController.text.isNotEmpty &&
                    catalogProvider.addPeopleController.text.length % 3 == 0 &&
                    catalogProvider.addPeopleIsLoading == false) {
                  return const MemorialBookIconWidget(
                    title: 'Nothing found',
                  );
                } else if(catalogProvider.addPeopleFoundPeoples.isEmpty &&
                    catalogProvider.addPeopleController.text.isEmpty) {
                  return const MemorialBookIconWidget(
                    title: 'Enter to find the profile',
                  );
                } else if(catalogProvider.addPeopleIsLoading == true) {
                  return SizedBox(
                    width: 7.h,
                    height: 7.h,
                    child: const LoadingIndicator(
                      indicatorType: Indicator.ballPulse,
                      colors: [
                        Color.fromRGBO(23, 94, 217, 1),
                      ],
                    ),
                  );
                } else {
                  final dataList = catalogProvider.addPeopleFoundPeoples[index];
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
                    index: index,
                    isAddingPeople: true,
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
                    id: dataList.id ?? 0,
                  );
                }
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 0.3.h,
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: catalogProvider.addPeopleFoundPeoples.isNotEmpty && catalogProvider.addPeopleIsLoading == false ?
              catalogProvider.addPeopleFoundPeoples.length :
              1,
            ),
          ],
        ),
      ),
    );
  }
}
