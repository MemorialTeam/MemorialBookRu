import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/provider/marketplace_provider.dart';
import 'package:memorial_book/screens/marketplace/product_card_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:memorial_book/widgets/marketplace_widgets/max_vertical_product_card.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../helpers/enums.dart';
import '../../models/market/item_model.dart';
import '../../widgets/search_engine.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({
    super.key,
  });

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {

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
                height: 2.2.h,
              ),
              Text(
                'Услуги',
                style: TextStyle(
                  fontFamily: ConstantsFonts.latoSemiBold,
                  fontSize: 18.5.sp,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 2.2.h,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.h,
                    crossAxisSpacing: 1.6.w,
                    mainAxisExtent: 30.2.h
                ),
                itemCount: marketplaceProvider.services.length,
                itemBuilder: (context, index) {
                  final ItemModel model = marketplaceProvider.services[index];
                  return PunchingAnimation(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ProductCardScreen(
                            model: model,
                            state: MarketplaceState.services,
                          ),
                        ),
                      ),
                      child: MaxVerticalProductCard(
                        symbol: ConstantsAssets.symbolProductImage,
                        model: model,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
