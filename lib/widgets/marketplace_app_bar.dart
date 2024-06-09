import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/screens/marketplace/order_history_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/animation/vertical_soft_navigation.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../provider/marketplace_provider.dart';
import '../screens/marketplace/shopping_cart_screen.dart';
import 'package:badges/badges.dart' as badge;

class MarketplaceAppBar extends StatelessWidget {
  const MarketplaceAppBar({
    Key? key,
    required this.child,
    this.toHideHistory,
    this.toHideBasket,
    this.isSearch,
    this.border,
  }) : super(key: key);

  final Widget child;

  final bool? toHideHistory;
  final bool? toHideBasket;
  final bool? isSearch;

  final Border? border;

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    return CupertinoTheme(
      data: CupertinoThemeData(
        barBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        textTheme: CupertinoTextThemeData(
          primaryColor: Theme.of(context).primaryColorDark,
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: UnScopeScaffold(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(12.h),
            child: SizedBox(
              height: 12.h,
              child: CupertinoNavigationBar(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
                border: border ?? Border.all(
                  color: const Color.fromRGBO(255, 255, 255, 0.9),
                ),
                transitionBetweenRoutes: false,
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 2.w,
                          top: 0.5.h,
                          bottom: 0.5.h,
                        ),
                        child: Image.asset(
                          ConstantsAssets.leadingBackImage,
                          width: 5.w,
                          color: const Color.fromRGBO(87, 167, 109, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    if(isSearch == true)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 7.w
                          ),
                          child: SearchEngine(
                            autofocus: true,
                            textStyle: TextStyle(
                              fontSize: 11.5.sp,
                              fontFamily: ConstantsFonts.latoRegular,
                              color: const Color.fromRGBO(32, 30, 31, 0.6),
                            ),
                            activeColor: const Color.fromRGBO(87, 167, 109, 1),
                            inactiveColor: const Color.fromRGBO(32, 30, 31, 0.4),
                            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                            title: 'Поиск по товарам, магазинам',
                            focusNode: marketplaceProvider.productsCategoryFocusNode,
                            controller: marketplaceProvider.productsCategoryTextEditingController,
                            isNotEmptyFunc: (name) async => await marketplaceProvider.searchProductsCategory(name),
                            isEmptyFunc: () async => await marketplaceProvider.getProductsCategory(),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    if(marketplaceProvider.shopModel?.shop != null && isSearch != true)
                      SizedBox(
                        width: 58.w,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Доставка: ${marketplaceProvider.shopModel?.shop?.name ?? 'Cemetery'}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color.fromRGBO(32, 30, 31, 1),
                                fontSize: 11.6.sp,
                                fontFamily: ConstantsFonts.latoSemiBold,
                              ),
                            ),
                            Text(
                              marketplaceProvider.shopModel?.shop?.address ?? 'There is no address',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color.fromRGBO(32, 30, 31, 1),
                                fontSize: 7.6.sp,
                                fontFamily: ConstantsFonts.latoRegular,
                                height: 0.8.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                trailing: marketplaceProvider.shopModel?.shop != null && isSearch != true?
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    toHideHistory == true ?
                    const SizedBox() :
                    PunchingAnimation(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const OrderHistoryScreen(),
                          ),
                        ),
                        child: Image.asset(
                          ConstantsAssets.orderHistoryImage,
                          height: 3.2.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    toHideBasket == true ?
                    const SizedBox() :
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        PunchingAnimation(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => Navigator.push(
                              context,
                              verticalSoftNavigation(
                                const ShoppingCartScreen(),
                              ),
                            ),
                            child: badge.Badge(
                              showBadge: marketplaceProvider.userCart?.count != null && marketplaceProvider.userCart?.count != 0,
                              badgeAnimation: const badge.BadgeAnimation.scale(
                                animationDuration: Duration(milliseconds: 400),
                                loopAnimation: false,
                                curve: Curves.fastOutSlowIn,
                                colorChangeAnimationCurve: Curves.easeInCubic,
                              ),
                              badgeContent: Text(
                                '${marketplaceProvider.userCart?.count}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 9.5.sp,
                                ),
                              ),
                              position: BadgePosition.topEnd(top: -0.7.h, end: -1.5.w),
                              child: Image.asset(
                                ConstantsAssets.basketImage,
                                height: 3.2.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ) :
                const SizedBox(),
              ),
            ),
          ),
          body: child,
        ),
      ),
    );
  }
}
