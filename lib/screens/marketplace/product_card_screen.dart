import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../helpers/enums.dart';
import '../../models/market/item_model.dart';
import '../../provider/marketplace_provider.dart';
import '../../widgets/marketplace_widgets/vertical_product_card.dart';

class ProductCardScreen extends StatelessWidget {
  const ProductCardScreen({
    super.key,
    required this.model,
    required this.state,
  });

  final ItemModel model;
  final MarketplaceState state;

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
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
                model.productName,
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
                'US \$${model.price}',
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
                model.description,
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
                'Другие ${state == MarketplaceState.products ?
                'товары' :
                'услуги'}',
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
                    final ItemModel modelOther = state == MarketplaceState.products ?
                    marketplaceProvider.products[index] :
                    marketplaceProvider.services[index];
                    if(modelOther == model) {
                      return const SizedBox();
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: VerticalProductCard(
                          symbol: ConstantsAssets.symbolProductImage,
                          width: 38.w,
                          model: modelOther,
                        ),
                      );
                    }
                  },
                  itemCount: state == MarketplaceState.products ?
                  marketplaceProvider.products.length :
                  marketplaceProvider.services.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}