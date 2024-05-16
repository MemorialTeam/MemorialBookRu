import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/marketplace_provider.dart';
import 'package:memorial_book/screens/marketplace/product_screen.dart';
import 'package:memorial_book/screens/marketplace/services_screen.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:memorial_book/widgets/marketplace_widgets/banner_card.dart';
import 'package:memorial_book/widgets/marketplace_widgets/category_card.dart';
import 'package:memorial_book/widgets/marketplace_widgets/vertical_product_card.dart';
import 'package:memorial_book/widgets/memorial_book_icon_widget.dart';
import 'package:memorial_book/widgets/search_engine.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/market/response/products_response_models/product_data_response_model.dart';
import '../../widgets/animation/punching_animation.dart';

class HomeMarketplaceScreen extends StatefulWidget {
  const HomeMarketplaceScreen({super.key});

  @override
  State<HomeMarketplaceScreen> createState() => _HomeMarketplaceScreenState();
}

class _HomeMarketplaceScreenState extends State<HomeMarketplaceScreen> {

  CarouselController controller = CarouselController();

  @override
  void initState() {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await marketplaceProvider.getProductsMain();
      await marketplaceProvider.getServicesMain();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    if(marketplaceProvider.shopModel != null) {
      return MarketplaceAppBar(
        child: ListView(
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
                            if(marketplaceProvider.productsMainModel?.productsData != null && marketplaceProvider.productsMainModel!.productsData!.isNotEmpty)
                            Expanded(
                              child: CategoryCard(
                                height: 24.h,
                                image: ConstantsAssets.productsImage,
                                title: 'Товары',
                                onTap: () async => await Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const ProductScreen(),
                                  ),
                                ),
                              ),
                            ),
                            if(marketplaceProvider.productsMainModel?.productsData != null && marketplaceProvider.productsMainModel!.productsData!.isNotEmpty && marketplaceProvider.servicesMainModel?.productsData != null && marketplaceProvider.servicesMainModel!.productsData!.isNotEmpty)
                            SizedBox(
                              width: 1.4.w,
                            ),
                            if(marketplaceProvider.servicesMainModel?.productsData != null && marketplaceProvider.servicesMainModel!.productsData!.isNotEmpty)
                            Expanded(
                              child: CategoryCard(
                                height: 24.h,
                                image: ConstantsAssets.servicesImage,
                                title: 'Услуги',
                                onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const ServicesScreen(),
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
                    child: marketplaceProvider.productsMainLoading == false ?
                    marketplaceProvider.productsMainModel?.productsData != null && marketplaceProvider.productsMainModel!.productsData!.isNotEmpty ?
                    ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final ProductDataResponseModel model = marketplaceProvider.productsMainModel!.productsData![index];
                        return PunchingAnimation(
                          child: GestureDetector(
                            // onTap: () => Navigator.push(
                            //   context,
                            //   CupertinoPageRoute(
                            //     builder: (context) => ProductCardScreen(
                            //       model: model,
                            //       state: MarketplaceState.products,
                            //     ),
                            //   ),
                            // ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 1.w,
                              ),
                              child: VerticalProductCard(
                                symbol: ConstantsAssets.symbolProductImage,
                                width: 38.w,
                                model: model,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 1.6.w,
                        );
                      },
                      itemCount: marketplaceProvider.productsMainModel?.productsData?.length ?? 0,
                    ) :
                    const MemorialBookIconWidget(
                      title: 'В магазине нет товаров',
                    ) :
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SkeletonLoaderWidget(
                          height: double.infinity,
                          width: 38.w,
                          borderRadius: 7,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 1.6.w,
                        );
                      },
                      itemCount: 4,
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
              child: marketplaceProvider.servicesMainLoading == false ?
              marketplaceProvider.servicesMainModel?.productsData != null && marketplaceProvider.servicesMainModel!.productsData!.isNotEmpty ?
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final ProductDataResponseModel model = marketplaceProvider.servicesMainModel!.productsData![index];
                  return PunchingAnimation(
                    child: GestureDetector(
                      // onTap: () => Navigator.push(
                      //   context,
                      //   CupertinoPageRoute(
                      //     builder: (context) => ProductCardScreen(
                      //       model: model,
                      //       state: MarketplaceState.services,
                      //     ),
                      //   ),
                      // ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: VerticalProductCard(
                          width: 38.w,
                          model: model,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 1.6.w,
                  );
                },
                itemCount: marketplaceProvider.servicesMainModel?.productsData?.length ?? 0,
              ) :
              const MemorialBookIconWidget(
                title: 'В магазине нет услуг',
              ) :
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SkeletonLoaderWidget(
                    height: double.infinity,
                    width: 38.w,
                    borderRadius: 7,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 1.6.w,
                  );
                },
                itemCount: 4,
              ),
            ),
          ],
        ),
      );
    }
    else {
      return Scaffold(
        body: SizedBox(),
      );
    }
  }
}
