import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/screens/marketplace/connection_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../provider/marketplace_provider.dart';
import '../../widgets/main_button.dart';
import '../../widgets/platform_scroll_physics.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    return MarketplaceAppBar(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
            ),
            child: ListView(
              physics: platformScrollPhysics(),
              children: [
                SizedBox(
                  height: 2.2.h,
                ),
                Text(
                  'Информация',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoSemiBold,
                    fontSize: 18.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                SizedBox(
                  height: 2.2.h,
                ),
                PunchingAnimation(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 1.w,
                      top: 1.h,
                      bottom: 1.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Способ оплаты',
                              style: TextStyle(
                                fontFamily: ConstantsFonts.latoSemiBold,
                                fontSize: 15.5.sp,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Text(
                              'Кредитная карта',
                              style: TextStyle(
                                fontFamily: ConstantsFonts.latoRegular,
                                fontSize: 11.5.sp,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  color: const Color.fromRGBO(0, 0, 0, 0.1),
                  width: double.infinity,
                  height: 0.1.h,
                ),
                SizedBox(
                  height: 1.h,
                ),
                PunchingAnimation(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 1.w,
                      top: 1.h,
                      bottom: 1.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Местоположение',
                              style: TextStyle(
                                fontFamily: ConstantsFonts.latoSemiBold,
                                fontSize: 15.5.sp,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Text(
                              'Москва, Россия',
                              style: TextStyle(
                                fontFamily: ConstantsFonts.latoRegular,
                                fontSize: 11.5.sp,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.2.h,
                ),
                Text(
                  'Информация о заказе',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoSemiBold,
                    fontSize: 18.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                SizedBox(
                  height: 2.2.h,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    3,
                    ((index) => Padding(
                      padding: EdgeInsets.only(
                        top: 1.h,
                        bottom: 1.h,
                        right: 2.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'A bouquet of red roses',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoSemiBold,
                                  fontSize: 11.5.sp,
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                              Text(
                                'Additional description or composition',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 9.5.sp,
                                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'qty 1',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 11.5.sp,
                                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                '\$705.00',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoSemiBold,
                                  fontSize: 11.5.sp,
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
                SizedBox(
                  height: 2.2.h,
                ),
                Text(
                  'Информация о заказе',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoSemiBold,
                    fontSize: 18.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                SizedBox(
                  height: 2.2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 2.w,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Подытог',
                            style: TextStyle(
                              fontFamily: ConstantsFonts.latoRegular,
                              fontSize: 9.5.sp,
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                          Text(
                            '\$705.00',
                            style: TextStyle(
                              fontFamily: ConstantsFonts.latoSemiBold,
                              fontSize: 11.5.sp,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.6.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Расписка',
                            style: TextStyle(
                              fontFamily: ConstantsFonts.latoRegular,
                              fontSize: 9.5.sp,
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                          Text(
                            '\$0',
                            style: TextStyle(
                              fontFamily: ConstantsFonts.latoSemiBold,
                              fontSize: 11.5.sp,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.6.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Доставка',
                            style: TextStyle(
                              fontFamily: ConstantsFonts.latoRegular,
                              fontSize: 9.5.sp,
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                          Text(
                            '\$25.00',
                            style: TextStyle(
                              fontFamily: ConstantsFonts.latoSemiBold,
                              fontSize: 11.5.sp,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.2.h,
                ),
                Container(
                  color: const Color.fromRGBO(0, 0, 0, 0.1),
                  width: double.infinity,
                  height: 0.1.h,
                ),
                SizedBox(
                  height: 2.2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 2.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Итоговая цена',
                        style: TextStyle(
                          fontFamily: ConstantsFonts.latoRegular,
                          fontSize: 9.5.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ),
                      Text(
                        '\$725.00',
                        style: TextStyle(
                          fontFamily: ConstantsFonts.latoSemiBold,
                          fontSize: 11.5.sp,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.6.h,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
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
                        'Grand Total',
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
                    text: 'ОПЛАТА',
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.2.w,
                    ),
                    textStyle: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 10.5.sp,
                      fontFamily: ConstantsFonts.latoSemiBold,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ConnectionScreen(),
                      ),
                    ),
                    activeColor: const Color.fromRGBO(87, 167, 109, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
