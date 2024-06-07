import 'package:flutter/material.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_people_screen.dart';
import '../../models/communitites/request/add_memorial_to_the_commnunity_request_model.dart';
import '../../widgets/cards/horizontal_mini_card_widget.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import '../../widgets/memorial_book_icon_widget.dart';
import '../../provider/catalog_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/platform_scroll_physics.dart';

class AddingProfilesInMemorialScreen extends StatefulWidget {
  const AddingProfilesInMemorialScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddingProfilesInMemorialScreen> createState() => _AddingProfilesInMemorialScreenState();
}

class _AddingProfilesInMemorialScreenState extends State<AddingProfilesInMemorialScreen> {
  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: ListView(
          physics: platformScrollPhysics(),
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
                isNotEmptyFunc: (text) async => await catalogProvider.addToCommunityPeopleSearch(),
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
                    title: 'Ничего не найдено',
                  );
                } else if(catalogProvider.addPeopleFoundPeoples.isEmpty &&
                    catalogProvider.addPeopleController.text.isEmpty) {
                  return const MemorialBookIconWidget(
                    title: 'Введите, чтобы найти профиль',
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
                  final String firstName = dataList.firstName == '' || dataList.firstName == null ?
                  '' :
                  '${dataList.firstName} ';
                  final String middleName = dataList.middleName == '' || dataList.middleName == null ?
                  '' :
                  '${dataList.middleName} ';
                  final String lastName = dataList.lastName == '' || dataList.lastName == null ?
                  '' :
                  '${dataList.lastName}';

                  return Stack(
                    children: [
                      HorizontalMiniCardWidget(
                        index: index,
                        isAddingPeople: true,
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
                        title: firstName+ middleName+ lastName,
                        subtitle: '${dataList.dateBirth.toString()} - ${dataList.dateDeath.toString()}',
                        id: dataList.id ?? 0,
                      ),
                      Positioned(
                        right: dataList.isLoading == false ?
                        0 :
                        6,
                        top: 1.2.h,
                        bottom: 1.2.h,
                        child: dataList.isLoading == false ?
                        IconButton(
                          onPressed: catalogProvider.isAdded(index) == StateOfMemorial.added ?
                          (() async {
                            setState(() {
                              dataList.isLoading = true;
                            });
                            await catalogProvider.removeMemorialFromTheCommunity(
                              context,
                              catalogProvider.communityProfileModel?.id ?? 0,
                              AddMemorialToTheCommunityRequestModel(
                                memorialId: dataList.id ?? 0,
                                memorialType: 'human',
                              ),
                              ((model) async {
                                if(model != null) {
                                  if(model.status == true) {
                                    await catalogProvider.updateMemorialsOfCommunity(catalogProvider.communityProfileModel?.id ?? 0).whenComplete(() => setState(() => dataList.isLoading = false));
                                    await catalogProvider.updateCommunityPeopleSearch();
                                  }
                                }
                              }),
                            );
                          }) :
                          (() async {
                            setState(() {
                              dataList.isLoading = true;
                            });
                            await catalogProvider.addMemorialToTheCommunity(
                              context,
                              catalogProvider.communityProfileModel?.id ?? 0,
                              AddMemorialToTheCommunityRequestModel(
                                memorialId: dataList.id ?? 0,
                                memorialType: 'human',
                              ),
                              ((model) async {
                                if(model != null) {
                                  if(model.status == true) {
                                    await catalogProvider.updateMemorialsOfCommunity(catalogProvider.communityProfileModel?.id ?? 0).whenComplete(() => setState(() => dataList.isLoading = false));
                                    await catalogProvider.updateCommunityPeopleSearch();
                                  }
                                }
                              }),
                            );
                          }),
                          icon: catalogProvider.isAdded(index) == StateOfMemorial.added ?
                          Icon(
                            Icons.remove_circle,
                            size: 24.sp,
                            color: Colors.red,
                          ) : Icon(
                            Icons.add_circle,
                            color: const Color.fromRGBO(18, 175, 82, 1),
                            size: 24.sp,
                          ),
                        ) :
                        SizedBox(
                          height: 4.h,
                          width: 4.h,
                          child: const LoadingIndicator(
                            indicatorType: Indicator.ballSpinFadeLoader,
                            colors: [
                              Color.fromRGBO(23, 94, 217, 1),
                            ],
                          ),
                        ),
                      ),
                    ],
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
