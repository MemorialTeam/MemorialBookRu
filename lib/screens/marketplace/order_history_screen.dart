import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/common_data.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/screens/marketplace/home_marketplace_screen.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:memorial_book/widgets/marketplace_widgets/product_history_card.dart';
import 'package:sizer/sizer.dart';

import '../../models/market/product_model.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {

  final CommonData data = CommonData();

  @override
  Widget build(BuildContext context) {
    return MarketplaceAppBar(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 2.2.h,
            ),
            Text(
              'История заказов:',
              style: TextStyle(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontFamily: ConstantsFonts.latoSemiBold,
                fontSize: 19.5.sp,
              ),
            ),
            data.historyList.isEmpty ?
            Column(
              children: [
                SizedBox(
                  height: 15.h,
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
                Center(
                  child: Text(
                    'У вас пока нет заказов.\nЕсли вам нужна помощь, то мы готовы помочь.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: ConstantsFonts.latoRegular,
                      fontSize: 9.5.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                MainButton(
                  text: 'ПЕРЕЙТИ НА ГЛАВНУЮ',
                  onTap: () {},
                  activeColor: const Color.fromRGBO(225, 228, 231, 1),
                  textStyle: TextStyle(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 9.5.sp,
                    fontFamily: ConstantsFonts.latoSemiBold,
                  ),
                ),
              ],
            ) :
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final ProductModel model = data.historyList[index];
                return ProductFromHistoryCard(
                  model: model,
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 0.1.h,
                  width: double.infinity,
                  color: const Color.fromRGBO(0, 0, 0, 0.1),
                );
              },
              itemCount: data.historyList.length,
            ),
          ],
        ),
      ),
    );
  }
}
