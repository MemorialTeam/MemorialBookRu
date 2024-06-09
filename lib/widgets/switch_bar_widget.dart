import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/provider/catalog_provider.dart';
import 'package:memorial_book/screens/main_flow/adding_profiles_in_memorial_screen.dart';
import 'package:memorial_book/screens/main_flow/all_profiles_screen.dart';
import 'package:memorial_book/widgets/link_widget.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/memorial_book_icon_widget.dart';
import 'package:memorial_book/widgets/platform_scroll_physics.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../helpers/constants.dart';
import '../helpers/enums.dart';
import '../models/communitites/request/add_memorial_to_the_commnunity_request_model.dart';
import '../screens/main_flow/some_selected_screens/selected_people_screen.dart';
import 'animation/animated_fade_out_in.dart';
import 'switch_bar_items/cemetery_contacts.dart';
import 'cards/horizontal_mini_card_widget.dart';

class SwitchBarWidget extends StatefulWidget {
  const SwitchBarWidget({
    Key? key,
    required this.switcher,
  }) : super(key: key);

  final CommunityOrCemeterySwitch switcher;

  @override
  State<SwitchBarWidget> createState() => _SwitchBarWidgetState();
}

class _SwitchBarWidgetState extends State<SwitchBarWidget> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final FocusNode cemeteryMemorialsNode = FocusNode();
  final FocusNode communityMemorialsNode = FocusNode();

  TextEditingController cemeteryMemorialsController = TextEditingController();
  TextEditingController communityMemorialsController = TextEditingController();

  int communitySearch = 1;
  int selectedMenuIndex = 0;

  List<Widget> widgetSwitch(int value) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    if(widget.switcher == CommunityOrCemeterySwitch.cemetery) {
      final model = catalogProvider.cemeteryProfileModel;
      return [
        Visibility(
          visible: selectedMenuIndex == 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Text(
              model?.description ?? '',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
        Visibility(
          visible: selectedMenuIndex == 1,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.6.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchEngine(
                  focusNode: communityMemorialsNode,
                  controller: communityMemorialsController,
                  isNotEmptyFunc: (text) => catalogProvider.communityMemorialsSearch(text, model?.id ?? 0),
                  isEmptyFunc: () => catalogProvider.gettingCommunityProfile(context, model?.id ?? 0),
                  isSearching: catalogProvider.isMemorialsCommunitySearch,
                ),
                SizedBox(
                  height: 2.2.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final dataList = model?.memorials?[index];
                    final String firstName = dataList?.firstName == '' || dataList?.firstName == null ?
                    '' :
                    '${dataList?.firstName} ';
                    final String lastName = dataList?.lastName == '' || dataList?.lastName == null ?
                    '' :
                    '${dataList?.lastName}';
                    return HorizontalMiniCardWidget(
                      isAddingPeople: false,
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => SelectedPeopleScreen(
                            avatar: dataList?.avatar ?? '',
                            id: dataList?.id ?? 0,
                          ),
                        ),
                      ),
                      avatar: dataList?.avatar,
                      title: firstName + lastName,
                      subtitle: '${dataList?.dateBirth.toString()} - ${dataList?.dateDeath.toString()}',
                      id: dataList?.id ?? 0,
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model?.memorials?.length != null && model!.memorials!.length > 5 ?
                  5 :
                  model?.memorials?.length ?? 0,
                ),
                if(model?.memorials?.length != null && model!.memorials!.length > 5)
                  Padding(
                    padding: EdgeInsets.only(
                      top: 2.2.h,
                    ),
                    child: MainButton(
                      text: 'ПОКАЗАТЬ БОЛЬШЕ',
                      activeColor: const Color.fromRGBO(245, 247, 249, 1),
                      border: Border.all(
                        color: const Color.fromRGBO(18, 175, 82, 1),
                        width: 0.1.h,
                      ),
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(18, 175, 82, 1),
                        fontFamily: ConstantsFonts.latoSemiBold,
                        fontSize: 9.5.sp,
                      ),
                      onTap: () {

                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: selectedMenuIndex == 2,
          child: const CemeteryContacts(),
        ),
      ];
    }
    else if(widget.switcher == CommunityOrCemeterySwitch.community) {
      final selectedCommunityModel = catalogProvider.communityProfileModel;
      final memorialModel = catalogProvider.memorialDataModel;
      return [
        Visibility(
          visible: value == 0,
          maintainState: true,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Text(
              selectedCommunityModel?.description ?? '',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
        if(selectedCommunityModel?.isAdmin == true)
        Visibility(
          visible: value == 1,
          maintainState: true,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.6.w,
            ),
            child: memorialModel != null && memorialModel.data!.isNotEmpty ?
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchEngine(
                  focusNode: communityMemorialsNode,
                  controller: communityMemorialsController,
                  isNotEmptyFunc: (text) async => await catalogProvider.communityMemorialsSearch(communityMemorialsController.text, selectedCommunityModel?.id ?? 0),
                  isEmptyFunc: () async => await catalogProvider.gettingMemorialsOfCommunity(
                    selectedCommunityModel?.id ?? 0,
                    ((model) {}),
                  ),
                  isSearching: catalogProvider.isMemorialsCommunitySearch,
                ),
                SizedBox(
                  height: 1.8.h,
                ),
                if(selectedCommunityModel?.isAdmin == true) GestureDetector(
                  onTap: () {
                    catalogProvider.disposeAddPeopleScreen();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const AddingProfilesInMemorialScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 1.8.h,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 4.w,
                        ),
                        Icon(
                          CupertinoIcons.plus,
                          size: 14.sp,
                          color: const Color.fromRGBO(23, 94, 217, 1),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          'Добавить профиль в "Мемориалы"',
                          style: TextStyle(
                            fontFamily: ConstantsFonts.latoRegular,
                            fontSize: 10.5.sp,
                            color: const Color.fromRGBO(23, 94, 217, 1),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final dataList = memorialModel.data![index];
                    return Stack(
                      children: [
                        HorizontalMiniCardWidget(
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
                          title: dataList.fullName ?? '',
                          subtitle: '${dataList.dateBirth.toString()} - ${dataList.dateDeath.toString()}',
                          isAddingPeople: false,
                          id: dataList.id ?? 0,
                        ),
                        if(selectedCommunityModel?.isAdmin == true)
                        Positioned(
                          right: dataList.isLoading == false ?
                          0 :
                          12,
                          top: 1.2.h,
                          bottom: 1.2.h,
                          child: dataList.isLoading == false ?
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                dataList.isLoading = true;
                              });
                              await catalogProvider.removeMemorialFromTheCommunity(
                                context,
                                selectedCommunityModel?.id ?? 0,
                                AddMemorialToTheCommunityRequestModel(
                                  memorialId: dataList.id ?? 0,
                                  memorialType: 'human',
                                ),
                                ((model) {
                                  if(model != null) {
                                    if(model.status == true) {
                                      catalogProvider.updateMemorialsOfCommunity(selectedCommunityModel?.id ?? 0).whenComplete(() => setState(() => dataList.isLoading = false));
                                    }
                                  }
                                }),
                              );
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              size: 22.sp,
                              color: Colors.red,
                            ),
                          ) :
                          SizedBox(
                            height: 4.h,
                            width: 4.h,
                            child: const LoadingIndicator(
                              indicatorType: Indicator.ballSpinFadeLoader,
                              colors: [
                                Colors.red,
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: memorialModel.data!.length >= 6 ?
                  6 :
                  memorialModel.data!.length,
                ),
                if(memorialModel.data!.length >= 7) Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    MainButton(
                      text: 'ПОКАЗАТЬ БОЛЬШЕ',
                      onTap: () async => await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => AllProfilesScreen(
                            communityId: selectedCommunityModel?.id ?? 0,
                            model: selectedCommunityModel,
                          ),
                        ),
                      ),
                      border: Border.all(
                        color: const Color.fromRGBO(23, 94, 217, 1),
                      ),
                      activeColor: const Color.fromRGBO(245, 247, 249, 1),
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(23, 94, 217, 1),
                        fontFamily: ConstantsFonts.latoBold,
                        fontSize: 9.5.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ) :
            GestureDetector(
              onTap: () {
                catalogProvider.disposeAddPeopleScreen();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AddingProfilesInMemorialScreen(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 1.8.h,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 4.w,
                    ),
                    Icon(
                      CupertinoIcons.plus,
                      size: 14.sp,
                      color: const Color.fromRGBO(23, 94, 217, 1),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Добавить профиль в "Мемориалы"',
                      style: TextStyle(
                        fontFamily: ConstantsFonts.latoRegular,
                        fontSize: 10.5.sp,
                        color: const Color.fromRGBO(23, 94, 217, 1),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        else Visibility(
          visible: value == 1,
          maintainState: true,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.6.w,
            ),
            child: memorialModel != null && memorialModel.data!.isNotEmpty ?
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchEngine(
                  focusNode: communityMemorialsNode,
                  controller: communityMemorialsController,
                  isNotEmptyFunc: (text) async => await catalogProvider.communityMemorialsSearch(communityMemorialsController.text, selectedCommunityModel?.id ?? 0),
                  isEmptyFunc: () async => await catalogProvider.gettingMemorialsOfCommunity(
                    selectedCommunityModel?.id ?? 0,
                    ((model) {}),
                  ),
                  isSearching: catalogProvider.isMemorialsCommunitySearch,
                ),
                SizedBox(
                  height: 1.8.h,
                ),
                if(selectedCommunityModel?.isAdmin == true) GestureDetector(
                  onTap: () {
                    catalogProvider.disposeAddPeopleScreen();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const AddingProfilesInMemorialScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 1.8.h,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 4.w,
                        ),
                        Icon(
                          CupertinoIcons.plus,
                          size: 14.sp,
                          color: const Color.fromRGBO(23, 94, 217, 1),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          'Добавить профиль в "Мемориалы"',
                          style: TextStyle(
                            fontFamily: ConstantsFonts.latoRegular,
                            fontSize: 10.5.sp,
                            color: const Color.fromRGBO(23, 94, 217, 1),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final dataList = memorialModel.data![index];
                    return Stack(
                      children: [
                        HorizontalMiniCardWidget(
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
                          title: dataList.fullName ?? '',
                          subtitle: '${dataList.dateBirth.toString()} - ${dataList.dateDeath.toString()}',
                          isAddingPeople: false,
                          id: dataList.id ?? 0,
                        ),
                        if(selectedCommunityModel?.isAdmin == true)
                          Positioned(
                            right: dataList.isLoading == false ?
                            0 :
                            12,
                            top: 1.2.h,
                            bottom: 1.2.h,
                            child: dataList.isLoading == false ?
                            IconButton(
                              onPressed: () async {
                                setState(() {
                                  dataList.isLoading = true;
                                });
                                await catalogProvider.removeMemorialFromTheCommunity(
                                  context,
                                  selectedCommunityModel?.id ?? 0,
                                  AddMemorialToTheCommunityRequestModel(
                                    memorialId: dataList.id ?? 0,
                                    memorialType: 'human',
                                  ),
                                  ((model) {
                                    if(model != null) {
                                      if(model.status == true) {
                                        catalogProvider.updateMemorialsOfCommunity(selectedCommunityModel?.id ?? 0).whenComplete(() => setState(() => dataList.isLoading = false));
                                      }
                                    }
                                  }),
                                );
                              },
                              icon: Icon(
                                Icons.remove_circle,
                                size: 22.sp,
                                color: Colors.red,
                              ),
                            ) :
                            SizedBox(
                              height: 4.h,
                              width: 4.h,
                              child: const LoadingIndicator(
                                indicatorType: Indicator.ballSpinFadeLoader,
                                colors: [
                                  Colors.red,
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: memorialModel.data!.length >= 6 ?
                  6 :
                  memorialModel.data!.length,
                ),
                if(memorialModel.data!.length >= 7) Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    MainButton(
                      text: 'ПОКАЗАТЬ БОЛЬШЕ',
                      onTap: () async => await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => AllProfilesScreen(
                            communityId: selectedCommunityModel?.id ?? 0,
                            model: selectedCommunityModel,
                          ),
                        ),
                      ),
                      border: Border.all(
                        color: const Color.fromRGBO(23, 94, 217, 1),
                      ),
                      activeColor: const Color.fromRGBO(245, 247, 249, 1),
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(23, 94, 217, 1),
                        fontFamily: ConstantsFonts.latoBold,
                        fontSize: 9.5.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ) :
            const MemorialBookIconWidget(
              title: 'В сообществе нет мемориалов...',
            ),
          ),
        ),
        Visibility(
          visible: value == 2,
          maintainState: true,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.4.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selectedCommunityModel?.website != null ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Вебсайт',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontFamily: ConstantsFonts.latoSemiBold,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(
                      height: 2.4.h,
                    ),
                    LinkWidget(
                      link: selectedCommunityModel?.website ?? '',
                    ),
                    SizedBox(
                      height: 2.4.h,
                    ),
                  ],
                ) :
                const SizedBox(),
                selectedCommunityModel?.socialLinks != null ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Социальное',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontFamily: ConstantsFonts.latoSemiBold,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(
                      height: 2.4.h,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        String key = selectedCommunityModel?.socialLinks?.keys.elementAt(index) ?? '';
                        final data = selectedCommunityModel?.socialLinks?[key];
                        return LinkWidget(
                          link: data ?? '',
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 2.h,
                        );
                      },
                      itemCount: selectedCommunityModel?.socialLinks?.length ?? 0,
                    ),
                  ],
                ) :
                const SizedBox(),
              ],
            ),
          ),
        ),
      ];
    }
    else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2.4.h,
      ),
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.4.h,
            child: TabBar(
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ),
              onTap: (indexMenu) {
                setState(() => selectedMenuIndex = indexMenu);
              },
              physics: platformScrollPhysics(),
              dividerColor: Colors.transparent,
              indicatorPadding: EdgeInsets.symmetric(
                horizontal: -4.w
              ),
              labelColor: const Color.fromRGBO(32, 30, 31, 0.8),
              labelStyle: TextStyle(
                fontFamily: ConstantsFonts.latoBold,
                fontSize: 11.5.sp,
              ),
              unselectedLabelColor: const Color.fromRGBO(32, 30, 31, 0.8),
              unselectedLabelStyle: TextStyle(
                fontFamily: ConstantsFonts.latoRegular,
                fontSize: 11.5.sp,
              ),
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: const Color.fromRGBO(232, 239, 252, 1),
              ),
              isScrollable: true,
              tabs: const [
                Tab(
                  text: 'Мемориальная стена',
                ),
                Tab(
                  text: 'Мемориалы',
                ),

                Tab(
                  text: 'Социальное',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          AnimatedFadeOutIn<int>(
            data: selectedMenuIndex,
            duration: const Duration(
              milliseconds: 200,
            ),
            builder: (value) => IndexedStack(
              index: selectedMenuIndex,
              children: widgetSwitch(value),
            ),
          ),
        ],
      ),
    );

  }
}
