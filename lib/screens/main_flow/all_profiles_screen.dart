import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/screens/main_flow/some_selected_screens/selected_people_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/communitites/request/add_memorial_to_the_commnunity_request_model.dart';
import '../../models/communitites/response/get_community_info_response_model.dart';
import '../../provider/catalog_provider.dart';
import '../../widgets/cards/horizontal_mini_card_widget.dart';
import '../../widgets/memorial_app_bar.dart';
import '../../widgets/memorial_book_icon_widget.dart';
import '../../widgets/platform_scroll_physics.dart';
import '../../widgets/search_engine.dart';
import '../../widgets/unscope_scaffold.dart';

class AllProfilesScreen extends StatefulWidget {
  const AllProfilesScreen({
    super.key,
    required this.communityId,
    required this.model,
  });

  final int communityId;
  final CommunitiesInfoResponseModel? model;

  @override
  State<AllProfilesScreen> createState() => _AllProfilesScreenState();
}

class _AllProfilesScreenState extends State<AllProfilesScreen> {

  @override
  void initState() {
    final catalogProvider = Provider.of<CatalogProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      catalogProvider.getAllMemorialsOfCommunity(widget.communityId);
    });
    super.initState();
  }

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
                focusNode: FocusNode(),
                controller: TextEditingController(),
                isNotEmptyFunc: (text) {},
                isEmptyFunc: () {},
              ),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if(catalogProvider.allMemorialsDataModel?.data != null &&
                    catalogProvider.allMemorialsDataModel!.data!.isEmpty) {
                  return const MemorialBookIconWidget(
                    title: 'There are no memorials',
                  );
                }
                else {
                  final memorialModel = catalogProvider.allMemorialsDataModel!.data![index];
                  if(catalogProvider.memorialPageNumber != catalogProvider.memorialLastPageNumber &&
                  index == catalogProvider.allMemorialsDataModel!.data!.length - 1 &&
                  catalogProvider.memorialPaginationLoading == false) {
                    // catalogProvider.paginationMemorialsOfCommunity(widget.communityId);
                  }
                  return Container(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    child: Stack(
                      children: [
                        HorizontalMiniCardWidget(
                          index: index,
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SelectedPeopleScreen(
                                avatar: memorialModel.avatar ?? '',
                                id: memorialModel.id ?? 0,
                              ),
                            ),
                          ),
                          avatar: memorialModel.avatar,
                          title: memorialModel.fullName ?? '',
                          subtitle: '${memorialModel.dateBirth} - ${memorialModel.dateDeath}',
                          id: memorialModel.id ?? 0,
                        ),
                        if(widget.model?.isAdmin == true) Positioned(
                          top: 0,
                          bottom: 0,
                          right: 4.w,
                          child: Center(
                            child: GestureDetector(
                              onTap: () => catalogProvider.removeMemorialFromTheCommunity(
                                context,
                                widget.communityId,
                                AddMemorialToTheCommunityRequestModel(
                                  memorialId: memorialModel.id ?? 0,
                                  memorialType: 'human',
                                ),
                                ((model) {

                                }),
                              ),
                              child: Icon(
                                Icons.remove_circle,
                                size: 22.sp,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 0.3.h,
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: catalogProvider.allMemorialsDataModel!.data!.isNotEmpty ?
              catalogProvider.allMemorialsDataModel!.data!.length :
              1,
            ),
            SizedBox(
              height: 0.3.h,
            ),
          ],
        ),
      ),
    );
  }
}
