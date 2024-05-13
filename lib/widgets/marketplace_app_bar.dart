import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/screens/marketplace/order_history_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../provider/marketplace_provider.dart';
import '../screens/marketplace/shopping_cart_screen.dart';

class MarketplaceAppBar extends StatelessWidget {
  const MarketplaceAppBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    if(marketplaceProvider.shopModel != null) {
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
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: SizedBox(
                height: 10.h,
                child: CupertinoNavigationBar(
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
                  border: Border.all(
                      color: const Color.fromRGBO(255, 255, 255, 0.9)
                  ),
                  transitionBetweenRoutes: false,
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            top: 5,
                            bottom: 5,
                          ),
                          child: Image.asset(
                            ConstantsAssets.leadingBackImage,
                            width: 20,
                            height: 16,
                            color: const Color.fromRGBO(87, 167, 109, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      SizedBox(
                        width: 58.w,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery: ${marketplaceProvider.shopModel?.shop?.name ?? 'Cemetery'}',
                              style: TextStyle(
                                color: const Color.fromRGBO(32, 30, 31, 1),
                                fontSize: 11.6.sp,
                                fontFamily: ConstantsFonts.latoSemiBold,
                              ),
                            ),
                            Text(
                              marketplaceProvider.shopModel?.shop?.address ?? 'There is no address',
                              maxLines: 2,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      SizedBox(
                        width: 5.w,
                      ),
                      PunchingAnimation(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const ShoppingCartScreen(),
                            ),
                          ),
                          child: SizedBox(
                            height: 3.2.h,
                            width: 3.7.h,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Image.asset(
                                    ConstantsAssets.basketImage,
                                    height: 3.2.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                marketplaceProvider.basket.isNotEmpty ?
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    height: 2.4.h,
                                    width: 2.4.h,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: Center(
                                      child: Text(
                                        marketplaceProvider.totalAdded().toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ConstantsFonts.latoRegular,
                                          fontSize: 9.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ) :
                                const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: child,
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: SizedBox(),
      );
    }
  }
}
