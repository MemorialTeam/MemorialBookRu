import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/screens/marketplace/product_card_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:memorial_book/widgets/marketplace_widgets/max_vertical_product_card.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../helpers/enums.dart';
import '../../widgets/search_engine.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
    required this.state,
  });

  final MarketplaceState state;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  String title() {
    switch(widget.state) {
      case MarketplaceState.services:
        return 'Услуги';
      case MarketplaceState.products:
        return 'Товары';
    }
  }

  String image() {
    switch(widget.state) {
      case MarketplaceState.services:
        return ConstantsAssets.testServicesImage;
      case MarketplaceState.products:
        return ConstantsAssets.testProductImage;
    }
  }

  int count() {
    switch(widget.state) {
      case MarketplaceState.services:
        return 5;
      case MarketplaceState.products:
        return 20;
    }
  }

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
                height: 2.h,
              ),
              Text(
                title(),
                style: TextStyle(
                  fontFamily: ConstantsFonts.latoSemiBold,
                  fontSize: 18.5.sp,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),

              widget.state == MarketplaceState.products ?
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.5.w,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchEngine(
                            textStyle: TextStyle(
                              fontSize: 11.5.sp,
                              fontFamily: ConstantsFonts.latoRegular,
                              color: const Color.fromRGBO(204, 204, 204, 1),
                            ),
                            inactiveColor: const Color.fromRGBO(204, 204, 204, 1),
                            backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
                            title: 'Поиск по товарам, магазинам',
                            focusNode: FocusNode(),
                            controller: TextEditingController(),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(246, 246, 246, 1),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(7.0),
                              ),
                            ),
                            isNotEmptyFunc: (value) {

                            },
                          ),
                        ),
                        SizedBox(
                          width: 2.5.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.4.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromRGBO(246, 246, 246, 1),
                          ),
                          child: Image.asset(
                            ConstantsAssets.sortImage,
                            height: 2.6.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ) :
              const SizedBox(),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.h,
                  crossAxisSpacing: 1.6.w,
                  mainAxisExtent: 30.2.h
                ),
                itemCount: count(),
                itemBuilder: (context, index) {
                  return PunchingAnimation(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ProductCardScreen(),
                        ),
                      ),
                      child: MaxVerticalProductCard(
                        image: image(),
                        symbol: ConstantsAssets.symbolProductImage,
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
