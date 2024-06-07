import 'dart:ui';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/screens/marketplace/check_out_screen.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:memorial_book/widgets/marketplace_widgets/product_card_shopping_cart.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../models/market/response/item_cart_response_model.dart';
import '../../provider/marketplace_provider.dart';
import 'package:animate_do/animate_do.dart';

import '../../widgets/platform_scroll_physics.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {

  @override
  void initState() {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_)  {
      marketplaceProvider.checkChangesCart(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    return MarketplaceAppBar(
      toHideBasket: true,
      child: Stack(
        children: [
          ListView(
            physics: platformScrollPhysics(),
            children: [
              SizedBox(
                height: 2.2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                child: Text(
                  'Корзина',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoSemiBold,
                    fontSize: 18.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              marketplaceProvider.userCart?.items != null && marketplaceProvider.userCart!.items!.isNotEmpty ?
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final ItemCartResponseModel model = marketplaceProvider.userCart!.items![index];
                  return Container(
                    decoration: index == marketplaceProvider.userCart!.items!.length - 1 ?
                    BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: const Color.fromRGBO(0, 0, 0, 0.1),
                          width: 0.1.h,
                        ),
                      ),
                    ) : null,
                    child: ProductCardShoppingCart(
                      model: model,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 0.1.h,
                    width: double.infinity,
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                  );
                },
                itemCount: marketplaceProvider.userCart?.items?.length ?? 0,
              ) :
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 13.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 23.w,
                      ),
                      child: Image.asset(
                        ConstantsAssets.blankImage,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      height: 3.6.h,
                    ),
                    Text(
                      'В корзине пока пусто',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: ConstantsFonts.latoSemiBold,
                        fontSize: 11.5.sp,
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      'Добавьте нужные Вам товары или услуги',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: ConstantsFonts.latoRegular,
                        fontSize: 9.5.sp,
                      ),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    MainButton(
                      text: 'ПЕРЕЙТИ НА ГЛАВНУЮ',
                      onTap: () => Navigator.of(context).popUntil(ModalRoute.withName(ConstantsNavigatorKeys.marketplaceRoute)),
                      activeColor: const Color.fromRGBO(225, 228, 231, 1),
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 9.5.sp,
                        fontFamily: ConstantsFonts.latoSemiBold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          marketplaceProvider.userCart?.items != null && marketplaceProvider.userCart!.items!.isNotEmpty ?
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Stack(
              children: [
                FadeInUp(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  delay: const Duration(
                    milliseconds: 200,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(6.w),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, -10),
                          blurRadius: 40,
                          spreadRadius: 0,
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Общая сумма',
                              style: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 0.5),
                                fontSize: 9.5.sp,
                                fontFamily: ConstantsFonts.latoSemiBold,
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            AnimatedFlipCounter(
                              prefix: '\$',
                              value: marketplaceProvider.grandTotal(),
                              fractionDigits: 2,
                              duration: const Duration(
                                milliseconds: 200,
                              ),
                              textStyle: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 19.5.sp,
                                fontFamily: ConstantsFonts.latoBlack,
                              ),
                            ),
                          ],
                        ),
                        MainButton(
                          text: 'ОФОРМИТЬ',
                          padding: EdgeInsets.symmetric(
                            vertical: 2.h,
                            horizontal: 10.2.w,
                          ),
                          textStyle: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 10.5.sp,
                            fontFamily: ConstantsFonts.latoSemiBold,
                          ),
                          onTap: () => Navigator.push(
                            context,
                            CupertinoDialogRoute(
                              builder: (context) => const CheckOutScreen(),
                              context: context,),
                          ),
                          activeColor: const Color.fromRGBO(87, 167, 109, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                if(marketplaceProvider.priceCheckCart == true)
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      color: Colors.transparent,
                      height: 12.6.h,
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 6.h,
                              child: const LoadingIndicator(
                                indicatorType: Indicator.ballPulse,
                                colors: [
                                  Colors.black,
                                ],
                              ),
                            ),
                            Text(
                              'Считаем сумму',
                              style: TextStyle(
                                fontFamily: ConstantsFonts.latoSemiBold,
                                fontSize: 11.5.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ) :
          const SizedBox(),
        ],
      ),
    );
  }
}
