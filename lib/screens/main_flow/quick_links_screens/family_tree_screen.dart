import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/account_provider.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/profile_creation_flow/creation_flow.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/animation/vertical_soft_navigation.dart';
import 'package:memorial_book/widgets/boot_engine.dart';
import 'package:memorial_book/widgets/cards/horizontal_mini_card_widget.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/memorial_book_icon_widget.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../helpers/enums.dart';
import '../../../provider/profile_creation_provider.dart';
import '../some_selected_screens/selected_people_screen.dart';
import '../some_selected_screens/selected_pet_screen.dart';

class FamilyTreeScreen extends StatefulWidget {
  const FamilyTreeScreen({Key? key}) : super(key: key);

  @override
  State<FamilyTreeScreen> createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen> {
  final FocusNode profilesFocusNode = FocusNode();
  final FocusNode petsFocusNode = FocusNode();

  final TextEditingController profilesController = TextEditingController();
  final TextEditingController petsController = TextEditingController();

  @override
  void initState() {
    final accountProvider = Provider.of<AccountProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      accountProvider.gettingCreatedHumansProfiles((model) {});
      accountProvider.gettingCreatedPetsProfiles((model) {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: SafeArea(
        child: UnScopeScaffold(
          backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
          body: Stack(
            children: [
              accountProvider.usersProfileButtonState == true ?
              Container(
                color: const Color.fromRGBO(255, 255, 255, 1),
                margin: EdgeInsets.only(
                  top: 9.0.h,
                ),
                height: double.infinity,
                width: double.infinity,
                child: BootEngine(
                  loadValue: accountProvider.humanLoading,
                  activeFlow: RefreshIndicator(
                    backgroundColor: const Color.fromRGBO(23, 94, 217, 1),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    displacement: 4.h,
                    onRefresh: () async => await accountProvider.gettingCreatedHumansProfiles((value) {
                      SVProgressHUD.dismiss();
                    }),
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 8.3.h,
                          leading: const SizedBox(),
                          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                          surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
                          floating: true,
                          flexibleSpace: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.4.w,
                              vertical: 1.2.h,
                            ),
                            child: SearchEngine(
                              focusNode: profilesFocusNode,
                              controller: profilesController,
                              isNotEmptyFunc: (text) {},
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            ((context, index) {
                              List modelList = accountProvider.createdHumanModel?.data ?? [];
                              if(accountProvider.createdHumanPageNumber != null &&
                                  accountProvider.createdHumanModel?.data != null &&
                                  index == accountProvider.createdHumanModel!.data!.length - 1 &&
                                  accountProvider.createdHumanPaginationLoading == false) {
                                accountProvider.paginationCreatedHumans();
                              }
                              if(modelList.isNotEmpty) {
                                final dataList = accountProvider.createdHumanModel!.data![index];
                                final String firstName = dataList.firstName == '' || dataList.firstName == null ?
                                '' :
                                '${dataList.firstName} ';
                                final String middleName = dataList.middleName == '' || dataList.middleName == null ?
                                '' :
                                '${dataList.middleName} ';
                                final String lastName = dataList.lastName == '' || dataList.lastName == null ?
                                '' :
                                '${dataList.lastName} ';
                                if(accountProvider.createdHumanPaginationLoading == true) {
                                  return Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 0.5.h,
                                      ),
                                      child: SizedBox(
                                        width: 6.h,
                                        child: const LoadingIndicator(
                                          indicatorType: Indicator.ballSpinFadeLoader,
                                          colors: [
                                            Color.fromRGBO(23, 94, 217, 1),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return HorizontalMiniCardWidget(
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
                                  status: dataList.status,
                                  avatar: dataList.avatar,
                                  title: lastName+ firstName+ middleName,
                                  subtitle: '${dataList.dateBirth} - ${dataList.dateDeath}',
                                );
                              }
                              else {
                                return const MemorialBookIconWidget(
                                  title: 'У Вас ещё нет\nсозданных профилей',
                                );
                              }
                            }),
                            childCount: (accountProvider.createdHumanModel?.data?.length ?? 1) + (accountProvider.createdHumanPaginationLoading == true ? 1 : 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  loadingFlow: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.4.w,
                              vertical: 1.2.h,
                            ),
                            child: SkeletonLoaderWidget(
                              height: 5.8.h,
                              width: double.infinity,
                              borderRadius: 7,
                            ),
                          ),
                        ),
                        Container(
                          height: 0.4.h,
                          color: const Color.fromRGBO(245, 247, 249, 1),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PunchingAnimation(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.6.w,
                                  vertical: 1.2.h,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SkeletonLoaderWidget(
                                      height: 7.h,
                                      width: 7.h,
                                      borderRadius: 50,
                                    ),
                                    SizedBox(
                                      width: 3.8.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SkeletonLoaderWidget(
                                            height: 2.3.h,
                                            width: index.isEven ?
                                            15.w :
                                            20.w,
                                            borderRadius: 5,
                                          ),
                                          SizedBox(
                                            height: 0.6.h,
                                          ),
                                          SkeletonLoaderWidget(
                                            height: 1.7.h,
                                            width: index.isEven ?
                                            34.w :
                                            40.w,
                                            borderRadius: 10,
                                          ),
                                          SizedBox(
                                            height: 0.8.h,
                                          ),
                                          SkeletonLoaderWidget(
                                            height: 1.7.h,
                                            width: 26.w,
                                            borderRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 0.4.h,
                              color: const Color.fromRGBO(245, 247, 249, 1),
                            );
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ) :
              Container(
                color: const Color.fromRGBO(255, 255, 255, 1),
                margin: EdgeInsets.only(
                  top: 9.0.h,
                ),
                height: double.infinity,
                width: double.infinity,
                child: BootEngine(
                  loadValue: accountProvider.petLoading,
                  activeFlow: RefreshIndicator(
                    backgroundColor: const Color.fromRGBO(23, 94, 217, 1),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    displacement: 4.h,
                    onRefresh: () async => await accountProvider.gettingCreatedPetsProfiles((value) {
                      SVProgressHUD.dismiss();
                    }),
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 8.3.h,
                          // elevation: 0,
                          leading: const SizedBox(),
                          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                          surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
                          floating: true,
                          flexibleSpace: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.4.w,
                              vertical: 1.2.h,
                            ),
                            child: SearchEngine(
                              focusNode: petsFocusNode,
                              controller: petsController,
                              isNotEmptyFunc: (text) {},
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 0.4.h,
                                color: const Color.fromRGBO(245, 247, 249, 1),
                              ),
                              accountProvider.createdPetsModel?.data != null && accountProvider.createdPetsModel!.data!.isNotEmpty ?
                              ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final dataList = accountProvider.createdPetsModel!.data![index];
                                  WidgetsBinding.instance.addPostFrameCallback((_){
                                    if(accountProvider.createdPetPageNumber != null &&
                                        index == accountProvider.createdPetsModel!.data!.length - 1 &&
                                        accountProvider.createdPetPaginationLoading == false) {
                                      accountProvider.paginationCreatedHumans();
                                    }
                                  });
                                  return HorizontalMiniCardWidget(
                                    onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => SelectedPetScreen(
                                          id: dataList.id ?? 0,
                                          avatar: dataList.avatar ?? '',
                                        ),
                                      ),
                                    ),
                                    isVerified: dataList.isCelebrity,
                                    status: dataList.status,
                                    avatar: dataList.avatar,
                                    title: dataList.name ?? '',
                                    subtitle: '${dataList.yearBirth} - ${dataList.yearDeath}',
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Container(
                                    height: 0.4.h,
                                    color: const Color.fromRGBO(245, 247, 249, 1),
                                  );
                                },
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: accountProvider.createdPetsModel!.data!.length,
                              ) :
                              const MemorialBookIconWidget(
                                title: 'У-пс...\nМы ничего не нашли',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  loadingFlow: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.4.w,
                              vertical: 1.2.h,
                            ),
                            child: SkeletonLoaderWidget(
                              height: 5.8.h,
                              width: double.infinity,
                              borderRadius: 7,
                            ),
                          ),
                        ),
                        Container(
                          height: 0.4.h,
                          color: const Color.fromRGBO(245, 247, 249, 1),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PunchingAnimation(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.6.w,
                                  vertical: 1.2.h,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SkeletonLoaderWidget(
                                      height: 7.h,
                                      width: 7.h,
                                      borderRadius: 50,
                                    ),
                                    SizedBox(
                                      width: 3.8.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SkeletonLoaderWidget(
                                            height: 2.3.h,
                                            width: index.isEven ?
                                            15.w :
                                            20.w,
                                            borderRadius: 5,
                                          ),
                                          SizedBox(
                                            height: 0.6.h,
                                          ),
                                          SkeletonLoaderWidget(
                                            height: 1.7.h,
                                            width: index.isEven ?
                                            34.w :
                                            40.w,
                                            borderRadius: 10,
                                          ),
                                          SizedBox(
                                            height: 0.8.h,
                                          ),
                                          SkeletonLoaderWidget(
                                            height: 1.7.h,
                                            width: 26.w,
                                            borderRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 0.4.h,
                              color: const Color.fromRGBO(245, 247, 249, 1),
                            );
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.4.w,
                  vertical: 1.2.h,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: PunchingAnimation(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: accountProvider.usersProfileButtonState == false ?
                          (() => accountProvider.switchProfileButtonButtonState()) :
                          null,
                          child: Container(
                            width: double.infinity,
                            height: 6.2.h,
                            decoration: BoxDecoration(
                              color: accountProvider.usersProfileButtonState == true ?
                              const Color.fromRGBO(255, 255, 255, 1) :
                              const Color.fromRGBO(245, 247, 249, 1),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 30,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 0),
                                  color: accountProvider.usersProfileButtonState == true ?
                                  const Color.fromRGBO(15, 20, 37, 0.1) :
                                  const Color.fromRGBO(15, 20, 37, 0.05),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Список профилей',
                                style: TextStyle(
                                  color: accountProvider.usersProfileButtonState == true ?
                                  const Color.fromRGBO(32, 30, 31, 1) :
                                  const Color.fromRGBO(32, 30, 31, 0.7),
                                  fontSize: 9.5.sp,
                                  fontFamily: ConstantsFonts.latoBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.2.w,
                    ),
                    Expanded(
                      child: PunchingAnimation(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: accountProvider.usersProfileButtonState == true ?
                          (() => accountProvider.switchProfileButtonButtonState()) :
                          null,
                          child: Container(
                            width: double.infinity,
                            height: 6.2.h,
                            decoration: BoxDecoration(
                              color: accountProvider.usersProfileButtonState == false ?
                              const Color.fromRGBO(255, 255, 255, 1) :
                              const Color.fromRGBO(245, 247, 249, 1),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 30,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 0),
                                  color: accountProvider.usersProfileButtonState == false ?
                                  const Color.fromRGBO(15, 20, 37, 0.1) :
                                  const Color.fromRGBO(15, 20, 37, 0.05),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Список дом. животных',
                                style: TextStyle(
                                  color: accountProvider.usersProfileButtonState == false ?
                                  const Color.fromRGBO(32, 30, 31, 1) :
                                  const Color.fromRGBO(32, 30, 31, 0.7),
                                  fontSize: 9.5.sp,
                                  fontFamily: ConstantsFonts.latoBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Align(
            alignment: Alignment.bottomRight,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  profileCreationProvider.disposePetCreate();
                  profileCreationProvider.disposeHumanCreate();
                  Navigator.push(
                    tabBarProvider.mainContext,
                    verticalSoftNavigation(
                      accountProvider.usersProfileButtonState ?
                      const CreationFlow(
                        checkFlow: CheckFlow.profile,
                      ) :
                      const CreationFlow(
                        checkFlow: CheckFlow.pet,
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(150),
                child: Image.asset(
                  ConstantsAssets.bluePlusImage,
                  width: 10.w,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


///Для будущего
// class GraphViewPage extends StatefulWidget {
//   const GraphViewPage({Key? key}) : super(key: key);
//
//   @override
//   _GraphViewPageState createState() => _GraphViewPageState();
// }

// class _GraphViewPageState extends State<GraphViewPage> {
//
//   bool isEmpty = false;
//
//   var json = {
//     "nodes": [
//       {
//         "id": 1,
//         "name": 'John Norris Bahcall',
//         "birthday": '1964',
//         "dayOfDeath": '2008',
//       },
//       {
//         "id": 2,
//         "name": 'John Norris Bahcall',
//         "birthday": '1964',
//         "dayOfDeath": '2008',
//       },
//       {
//         "id": 3,
//         "name": 'John Norris Bahcall',
//         "birthday": '1964',
//         "dayOfDeath": '2008',
//       },
//       {
//         "id": 4,
//         "name": 'John Norris Bahcall',
//         "birthday": '1964',
//         "dayOfDeath": '2008',
//       },
//       {
//         "id": 5,
//         "name": 'John Norris Bahcall',
//         "birthday": '1964',
//         "dayOfDeath": '2008',
//       },
//       {
//         "id": 6,
//         "name": 'John Norris Bahcall',
//         "birthday": '1964',
//         "dayOfDeath": '2008',
//       },
//       {
//         "id": 7,
//         "name": 'John Norris Bahcall',
//         "birthday": '1964',
//         "dayOfDeath": '2008',
//       },
//       {
//         "id": 8,
//         "name": 'John Norris Bahcall',
//         "birthday": '1964',
//         "dayOfDeath": '2008',
//       },
//     ],
//     "edges": [
//       {"from": 1, "to": 2},
//       {"from": 2, "to": 3},
//       {"from": 2, "to": 4},
//       {"from": 2, "to": 5},
//       {"from": 5, "to": 6},
//       {"from": 5, "to": 7},
//       {"from": 6, "to": 8}
//     ]
//   };
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         isEmpty == false ?
//         Expanded(
//           child: InteractiveViewer(
//               constrained: false,
//               scaleEnabled: false,
//               boundaryMargin: const EdgeInsets.all(100),
//               minScale: 0.01,
//               maxScale: 5.6,
//               child: GraphView(
//                 graph: graph,
//                 algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
//                 paint: Paint()
//                   ..color = const Color.fromRGBO(32, 30, 31, 0.2)
//                   ..strokeWidth = 1
//                   ..style = PaintingStyle.fill,
//                 builder: (Node node) {
//                   int a = node.key!.value;
//                   List<Map<String, Object>>? nodes = json['nodes'];
//                   Map nodeValue = nodes!.firstWhere((element) => element['id'] == a);
//                   return getNodeText(nodeValue['birthday'], nodeValue['dayOfDeath'], nodeValue['name']);
//                 },
//               )),
//         ) :
//         Container(
//           width: double.infinity,
//           margin: EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 10.h,
//           ),
//           padding: EdgeInsets.symmetric(
//             vertical: 6.h,
//           ),
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(
//                 ConstantsAssets.dottedSquareImage,
//               ),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'No profile is in your family tree.',
//                   style: TextStyle(
//                     color: const Color.fromRGBO(32, 30, 31, 1),
//                     fontSize: 14.sp,
//                     fontFamily: ConstantsFonts.latoBlack,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 1.2.h,
//                 ),
//                 Text(
//                   'The cemetery may have already added\ninformation and you can see it on a map.',
//                   style: TextStyle(
//                     color: const Color.fromRGBO(32, 30, 31, 1),
//                     fontSize: 9.5.sp,
//                     fontFamily: ConstantsFonts.latoRegular,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 1.2.h,
//                 ),
//                 Text(
//                   'If not, just create a new profile.',
//                   style: TextStyle(
//                     color: const Color.fromRGBO(32, 30, 31, 1),
//                     fontSize: 9.5.sp,
//                     fontFamily: ConstantsFonts.latoRegular,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Random r = Random();
//
//   int n = 1;
//
//   Widget getNodeText(String startYear, String endYear, String name) {
//     return Container(
//       color: const Color.fromRGBO(245, 247, 249, 1),
//       child: Column(
//         children: [
//           Container(
//             height: 10.h,
//             width: 10.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               image: DecorationImage(
//                 image: AssetImage(
//                   ConstantsAssets.avatarTestImage,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 1.h,
//           ),
//           Text(
//             '$startYear - $endYear г.',
//             style: TextStyle(
//               color: const Color.fromRGBO(32, 30, 31, 1),
//               fontFamily: ConstantsFonts.latoRegular,
//               fontSize: 8.5.sp,
//             ),
//           ),
//           SizedBox(
//             height: 1.4.h,
//           ),
//           Text(
//             name,
//             style: TextStyle(
//               color: const Color.fromRGBO(32, 30, 31, 1),
//               fontFamily: ConstantsFonts.latoRegular,
//               fontSize: 8.5.sp,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   final Graph graph = Graph();
//   BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
//
//   @override
//   void initState() {
//     super.initState();
//     var edges = json['edges']!;
//     for (var element in edges) {
//       var fromNodeId = element['from'];
//       var toNodeId = element['to'];
//       graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
//     }
//     builder.orientation = BuchheimWalkerConfiguration.ORIENTATION_BOTTOM_TOP;
//     builder
//       ..siblingSeparation = (25)
//       ..levelSeparation = (100)
//       ..subtreeSeparation = (100);
//   }
// }