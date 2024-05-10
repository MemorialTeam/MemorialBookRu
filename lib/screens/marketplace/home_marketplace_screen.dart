import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/helpers/enums.dart';
import 'package:memorial_book/provider/marketplace_provider.dart';
import 'package:memorial_book/screens/marketplace/product_screen.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:memorial_book/widgets/marketplace_widgets/banner_card.dart';
import 'package:memorial_book/widgets/marketplace_widgets/category_card.dart';
import 'package:memorial_book/widgets/marketplace_widgets/vertical_product_card.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/animation/punching_animation.dart';

class HomeMarketplaceScreen extends StatefulWidget {
  const HomeMarketplaceScreen({super.key});

  @override
  State<HomeMarketplaceScreen> createState() => _HomeMarketplaceScreenState();
}

class _HomeMarketplaceScreenState extends State<HomeMarketplaceScreen> {

  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    return MarketplaceAppBar(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                border: Border(
                  bottom: BorderSide(
                    width: 0.14.h,
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                  ),
                ),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.5.w,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
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
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CategoryCard(
                                height: 24.h,
                                image: ConstantsAssets.productsImage,
                                title: 'Товары',
                                onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const ProductScreen(
                                      state: MarketplaceState.products,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.4.w,
                            ),
                            Expanded(
                              child: CategoryCard(
                                height: 24.h,
                                image: ConstantsAssets.servicesImage,
                                title: 'Услуги',
                                onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const ProductScreen(
                                      state: MarketplaceState.services,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                  CarouselSlider(
                    carouselController: controller,
                    items: List.generate(3, (index) {
                      return PunchingAnimation(
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: BannerCard(
                            networkImage: ConstantsAssets.bannerImage,
                          ),
                        ),
                      );
                    }),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 4.5,
                      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      onPageChanged: marketplaceProvider.onPageChanged,
                      viewportFraction: 0.92,
                      enlargeFactor: 0.1,
                      autoPlayInterval: const Duration(
                        seconds: 5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 2.5.w,
                    ),
                    child: Text(
                      'Товары магазина',
                      style: TextStyle(
                        color: const Color.fromRGBO(32, 30, 31, 1),
                        fontSize: 15.5.sp,
                        fontFamily: ConstantsFonts.latoSemiBold,
                      ),
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
                  SizedBox(
                    height: 0.5.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 2.5.w,
              ),
              child: Text(
                'Услуги магазина',
                style: TextStyle(
                  color: const Color.fromRGBO(32, 30, 31, 1),
                  fontSize: 15.5.sp,
                  fontFamily: ConstantsFonts.latoSemiBold,
                ),
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
                      image: ConstantsAssets.testServicesImage,
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
    );
  }
}
