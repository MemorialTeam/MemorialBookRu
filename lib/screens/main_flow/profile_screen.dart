import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/screens/flow_build.dart';
import 'package:memorial_book/screens/main_flow/cemetery_screen.dart';
import 'package:memorial_book/screens/main_flow/change_information_screen.dart';
import 'package:memorial_book/screens/main_flow/quick_links_screens/family_tree_screen.dart';
import 'package:memorial_book/screens/terms_and_conditions_screen.dart';
import 'package:memorial_book/widgets/account_widgets/quick_link_widget.dart';
import 'package:memorial_book/widgets/element_selection/popupAlertWidget.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/tab_bar_widget/tab_bar_core.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../provider/account_provider.dart';
import '../../provider/auth_provider.dart';
import '../../provider/tab_bar_provider.dart';
import '../../widgets/platform_scroll_physics.dart';
import '../../widgets/skeleton_loader_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Timer? timer;

  @override
  void initState() {
    final _accountProvider = Provider.of<AccountProvider>(
      context,
      listen: false,
    );
    final _authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    if(_authProvider.userRules == 'authorized') {
      _accountProvider.getUserInfo(context);

      timer = Timer.periodic(
        const Duration(
          seconds: 10,
        ),
        ((timer) => _accountProvider.getUserInfo(context)),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    void logout() {
      if(authProvider.userRules == 'authorized') {
        authProvider.logoutAuthorized(tabBarProvider.mainContext);
      } else if(authProvider.userRules == 'guest') {
        authProvider.logoutGuest(tabBarProvider.mainContext);
      }
    }
    return MemorialAppBar(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: SafeArea(
          child: authProvider.userRules == 'authorized' ?
          ValueListenableBuilder(
            valueListenable: accountProvider.user,
            builder: (context, data, _) => FlowBuild(
              loadingFlow: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.2.w,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 2.4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 40.w,
                      ),
                      child: SkeletonLoaderWidget(
                        height: 4.h,
                        width: double.infinity,
                        borderRadius: 14,
                      ),
                    ),
                    SizedBox(
                      height: 2.4.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 3.2.w,
                        ),
                        child: Column(
                          children: [
                            SkeletonLoaderWidget(
                              height: 11.8.h,
                              width: 11.8.h,
                              borderRadius: 1000,
                            ),
                            SizedBox(
                              height: 3.1.h,
                            ),
                            SkeletonLoaderWidget(
                              height: 2.8.h,
                              width: 9.h,
                              borderRadius: 14,
                            ),
                            SizedBox(
                              height: 0.8.h,
                            ),
                            SkeletonLoaderWidget(
                              height: 2.4.h,
                              width: 12.h,
                              borderRadius: 14,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SkeletonLoaderWidget(
                                      height: 3.2.h,
                                      width: 9.w,
                                      borderRadius: 14,
                                    ),
                                    SizedBox(
                                      height: 1.4.h,
                                    ),
                                    SkeletonLoaderWidget(
                                      height: 2.3.h,
                                      width: 14.w,
                                      borderRadius: 14,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SkeletonLoaderWidget(
                                      height: 3.2.h,
                                      width: 9.w,
                                      borderRadius: 14,
                                    ),
                                    SizedBox(
                                      height: 1.4.h,
                                    ),
                                    SkeletonLoaderWidget(
                                      height: 2.3.h,
                                      width: 16.w,
                                      borderRadius: 14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                              ),
                              child: SkeletonLoaderWidget(
                                height: 5.h,
                                width: double.infinity,
                                borderRadius: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.2.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: SkeletonLoaderWidget(
                            height: 3.6.h,
                            width: 30.w,
                            borderRadius: 14,
                          ),
                        ),
                        SizedBox(
                          height: 2.2.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 5,
                                  left: 16,
                                ),
                                child: SkeletonLoaderWidget(
                                  height: 12.5.h,
                                  width: double.infinity,
                                  borderRadius: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 16,
                                ),
                                child: SkeletonLoaderWidget(
                                  height: 12.5.h,
                                  width: double.infinity,
                                  borderRadius: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.4.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 5,
                                  left: 16,
                                ),
                                child: SkeletonLoaderWidget(
                                  height: 12.5.h,
                                  width: double.infinity,
                                  borderRadius: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 16,
                                ),
                                child: SkeletonLoaderWidget(
                                  height: 12.5.h,
                                  width: double.infinity,
                                  borderRadius: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              activeFlow: ListView(
                physics: platformScrollPhysics(),
                children: [
                  SizedBox(
                    height: 2.4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.2.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Информация о профиле',
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontFamily: ConstantsFonts.latoRegular,
                          ),
                        ),
                        SizedBox(
                          height: 2.4.h,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3.2.w,
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 6.h,
                                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                                  child: data?.user?.avatar != null && data?.user?.avatar != '' ?
                                  CachedNetworkImage(
                                    imageUrl: data!.user!.avatar!,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, indicator) {
                                      return const SkeletonLoaderWidget(
                                        height: double.infinity,
                                        width: double.infinity,
                                        borderRadius: 1000,
                                      );
                                    },
                                    errorWidget: (context, indicator, error) {
                                      return Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(ConstantsAssets.memorialBookLogoImage),
                                          ),
                                        ),
                                      );
                                    },
                                  ) : Center(
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 53.sp,
                                      color: const Color.fromRGBO(186, 186, 186, 1),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.1.h,
                                ),
                                Text(
                                  data?.user?.username ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: ConstantsFonts.latoBold,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.8.h,
                                ),
                                Text(
                                  'Создатель профиля',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 102, 102, 102),
                                    fontFamily: ConstantsFonts.latoRegular,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data?.user?.profilesCount?.toString() ?? '',
                                          style: TextStyle(
                                            fontSize: 21.sp,
                                            fontFamily: ConstantsFonts.latoBlack,
                                            color: const Color.fromRGBO(23, 94, 217, 1),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.4.h,
                                        ),
                                        Text(
                                          'Профили',
                                          style: TextStyle(
                                            fontSize: 11.5.sp,
                                            fontFamily: ConstantsFonts.latoRegular,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          data?.user?.accessesCount?.toString() ?? '',
                                          style: TextStyle(
                                            fontSize: 21.sp,
                                            fontFamily: ConstantsFonts.latoBlack,
                                            color: const Color.fromRGBO(23, 94, 217, 1),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.4.h,
                                        ),
                                        Text(
                                          'Доступы',
                                          style: TextStyle(
                                            fontSize: 11.5.sp,
                                            fontFamily: ConstantsFonts.latoRegular,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 18.w,
                                  ),
                                  child: MainButton(
                                    activeColor: Colors.transparent,
                                    border: Border.all(
                                      color: const Color.fromRGBO(23, 94, 217, 1),
                                    ),
                                    text: 'ИЗМЕНИТЬ ДАННЫЕ',
                                    textStyle: TextStyle(
                                      color: const Color.fromRGBO(23, 94, 217, 1),
                                      fontSize: 9.5.sp,
                                      fontFamily: ConstantsFonts.latoBold,
                                    ),
                                    onTap: () => Navigator.push(
                                      tabBarProvider.mainContext,
                                      CupertinoDialogRoute(
                                        builder: (context) => ChangeInformationScreen(
                                          model: data!.user!,
                                        ),
                                        context: tabBarProvider.mainContext,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.2.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.2.w,
                        ),
                        child: Text(
                          'Быстрые ссылки',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: ConstantsFonts.latoBlack,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.2.h,
                      ),
                      Row(
                        children: [
                          QuickLinkWidget(
                            isActive: true,
                            title: 'Профили',
                            onTap: () async => await accountProvider.gettingUserProfiles(context, true),
                            image: Image.asset(
                              ConstantsAssets.profilesLinkImage,
                              height: 3.6.h,
                              width: 10.w,
                            ),
                            margin: EdgeInsets.only(
                              right: 1.w,
                              left: 3.2.w,
                            ),
                          ),
                          QuickLinkWidget(
                            isActive: true,
                            title: 'Питомцы',
                            onTap: () async => await accountProvider.gettingUserProfiles(context, false),
                            image: Image.asset(
                              ConstantsAssets.petTreeLinkImage,
                              width: 7.4.w,
                              height: 4.h,
                            ),
                            margin: EdgeInsets.only(
                              left: 1.w,
                              right: 3.2.w,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.4.h,
                      ),
                      Row(
                        children: [
                          QuickLinkWidget(
                            isActive: true,
                            title: 'Места',
                            onTap: () {
                              Navigator.push(
                                tabBarProvider.mainContext,
                                CupertinoPageRoute(
                                  builder: (context) => const CemeteryScreen(),
                                ),
                              );
                            },
                            image: Image.asset(
                              ConstantsAssets.placesLinkImage,
                              height: 4.4.h,
                              width: 8.w,
                            ),
                            margin: EdgeInsets.only(
                              right: 1.w,
                              left: 3.2.w,
                            ),
                          ),
                          QuickLinkWidget(
                            isActive: true,
                            title: 'Сообщества',
                            onTap: () {
                              tabBarProvider.selectTab(TabItem.communities);
                            },
                            image: Image.asset(
                              ConstantsAssets.communitiesLinkImage,
                              width: 8.9.w,
                              height: 4.4.h,
                            ),
                            margin: EdgeInsets.only(
                              left: 1.w,
                              right: 3.2.w,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.4.h,
                      ),
                      Row(
                        children: [
                          QuickLinkWidget(
                            isActive: false,
                            title: 'Семейное дерево',
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => FamilyTreeScreen(),
                                ),
                              );
                            },
                            image: Image.asset(
                              ConstantsAssets.familyTreeLinkImage,
                              width: 8.2.w,
                              height: 4.4.h,
                              color: const Color.fromRGBO(52, 168, 83, 0.2),
                            ),
                            margin: EdgeInsets.only(
                              right: 1.w,
                              left: 3.2.w,
                            ),
                          ),
                          QuickLinkWidget(
                            isActive: false,
                            title: 'Магазин',
                            onTap: () {

                            },
                            image: Image.asset(
                              ConstantsAssets.marketPlaceLinkImage,
                              height: 4.4.h,
                              width: 8.6.w,
                              color: const Color.fromRGBO(25, 114, 216, 0.1),
                            ),
                            margin: EdgeInsets.only(
                              left: 1.w,
                              right: 3.2.w,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.4.h,
                      ),
                      Row(
                        children: [
                          QuickLinkWidget(
                            isActive: false,
                            title: 'Напоминание',
                            onTap: () {},
                            image: Image.asset(
                              ConstantsAssets.reminderImage,
                              height: 4.4.h,
                            ),
                            margin: EdgeInsets.only(
                              right: 1.w,
                              left: 3.2.w,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 12.5.h,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                left: 1.w,
                                right: 3.2.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.2.w,
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color.fromRGBO(130, 130, 130, 0.1),
                                  ),
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(130, 130, 130, 0.1),
                                  ),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {

                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5.w,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ConstantsAssets.helpSupportImage,
                                          height: 2.6.h,
                                        ),
                                        SizedBox(
                                          width: 2.6.w,
                                        ),
                                        Text(
                                          'Help & Support',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontFamily: ConstantsFonts.latoBold,
                                            color: const Color.fromRGBO(130, 130, 130, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {

                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ConstantsAssets.settingsAndPrivacyImage,
                                        height: 2.8.h,
                                      ),
                                      SizedBox(
                                        width: 2.6.w,
                                      ),
                                      Text(
                                        'Настройки и конфиденциальность',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontFamily: ConstantsFonts.latoBold,
                                          color: const Color.fromRGBO(130, 130, 130, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color.fromRGBO(130, 130, 130, 0.1),
                                  ),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => const TermsAndConditionsScreen(
                                          isConfirm: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5.w,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ConstantsAssets.termsAndConditionsImage,
                                          height: 2.6.h,
                                        ),
                                        SizedBox(
                                          width: 2.6.w,
                                        ),
                                        Text(
                                          'Условия пользования',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontFamily: ConstantsFonts.latoBold,
                                            color: const Color.fromRGBO(130, 130, 130, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(130, 130, 130, 0.1),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    popupAlertWidget(
                                      title: 'Выход...',
                                      subtitle: 'Вы уверены, что хотите выйти из аккаунта?',
                                      context: tabBarProvider.mainContext,
                                      onCancel: () => Navigator.pop(tabBarProvider.mainContext),
                                      onAgree: () {
                                        Navigator.pop(tabBarProvider.mainContext);
                                        logout();
                                        tabBarProvider.tabBarDispose();
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5.w,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Выйти',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontFamily: ConstantsFonts.latoBold,
                                          color: const Color.fromRGBO(130, 130, 130, 1),
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
                      SizedBox(
                        height: 2.4.h,
                      ),
                    ],
                  ),
                ],
              ),
              errorText: data?.message ?? 'Error',
            ),
          ) :
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ConstantsAssets.memorialBookLogoImage,
                  height: 52,
                  width: 52,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Image.asset(
                  ConstantsAssets.memorialBookTextImage,
                  height: 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
