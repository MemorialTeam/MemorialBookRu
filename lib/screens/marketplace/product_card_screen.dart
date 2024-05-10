import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/constants.dart';
import '../../widgets/marketplace_widgets/vertical_product_card.dart';

class ProductCardScreen extends StatelessWidget {
  const ProductCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketplaceAppBar(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 48.h,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      ConstantsAssets.testProductImage,
                      width: double.infinity,
                    );
                  },
                ),
              ),
              Text(
                'Товар',
                style: TextStyle(
                  fontFamily: ConstantsFonts.latoBold,
                  fontSize: 19.5.sp,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'US \$29,99',
                style: TextStyle(
                  fontFamily: ConstantsFonts.latoRegular,
                  fontSize: 15.5.sp,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Описание / Состав',
                style: TextStyle(
                  fontFamily: ConstantsFonts.latoSemiBold,
                  fontSize: 15.5.sp,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Text(
                'Значимость этих проблем настолько очевидна, что консультация с широким активом позволяет выполнять важные задания.',
                style: TextStyle(
                  fontFamily: ConstantsFonts.latoRegular,
                  fontSize: 9.5.sp,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              MainButton(
                activeColor: const Color.fromRGBO(87, 167, 109, 1),
                text: 'КУПИТЬ',
                textStyle: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 10.5.sp,
                  fontFamily: ConstantsFonts.latoBlack,
                ),
                onTap: () {},
              ),
              SizedBox(
                height: 1.5.h,
              ),
              MainButton(
                activeColor: const Color.fromRGBO(225, 228, 231, 1),
                text: 'Заказать возложение',
                onTap: () {},
                textStyle: TextStyle(
                  color: const Color.fromRGBO(32, 30, 31, 1),
                  fontSize: 10.5.sp,
                  fontFamily: ConstantsFonts.latoBlack,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                width: double.infinity,
                color: const Color.fromRGBO(0, 0, 0, 0.1),
                height: 0.1.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Другие товары',
                style: TextStyle(
                  color: const Color.fromRGBO(32, 30, 31, 1),
                  fontSize: 15.5.sp,
                  fontFamily: ConstantsFonts.latoSemiBold,
                ),
              ),
              SizedBox(
                height: 1.6.h,
              ),
              SizedBox(
                height: 30.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.w,
                      ),
                      child: VerticalProductCard(
                        image: ConstantsAssets.testProductImage,
                        symbol: ConstantsAssets.symbolProductImage,
                        width: 38.w,
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}