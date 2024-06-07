import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/screens/marketplace/shopping_cart_screen.dart';
import 'package:memorial_book/widgets/boot_engine.dart';
import 'package:memorial_book/widgets/full_screen_gallery_market.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:memorial_book/widgets/marketplace_widgets/indicator_product_gallery.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../helpers/enums.dart';
import '../../models/market/response/item_cart_response_model.dart';
import '../../models/market/response/products_response_models/product_data_response_model.dart';
import '../../provider/marketplace_provider.dart';
import '../../widgets/animation/punching_animation.dart';
import '../../widgets/animation/vertical_soft_navigation.dart';
import '../../widgets/element_selection/popupAlertWidget.dart';
import '../../widgets/platform_scroll_physics.dart';

class ProductCardScreen extends StatefulWidget {
  const ProductCardScreen({
    super.key,
    required this.state,
  });

  final MarketplaceProductType state;

  @override
  State<ProductCardScreen> createState() => _ProductCardScreenState();
}

class _ProductCardScreenState extends State<ProductCardScreen> {

  int page = 0;

  ScrollController pageController = ScrollController();

  Widget price() {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    final ProductDataResponseModel? product = marketplaceProvider.product;
    bool checkInCart = false;
    int quantity = 0;
    int productId = 0;
    int price = 0;
    for(ItemCartResponseModel a in marketplaceProvider.userCart?.items ?? []) {
      if(a.productId == product?.id) {
        checkInCart = true;
        quantity = a.quantity ?? 0;
        productId = a.id ?? 0;
        price = a.totalDiscountPrice != null && a.totalDiscountPrice! != 0 ?
        a.totalDiscountPrice! :
        a.price ?? 0;
        break;
      } else {
        checkInCart = false;
      }
    }
    if(checkInCart == true) {
      return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: FadeInUp(
          duration: const Duration(
            milliseconds: 600,
          ),
          delay: const Duration(
            milliseconds: 200,
          ),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -10),
                  blurRadius: 40,
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                ),
              ],
            ),
            padding: EdgeInsets.all(6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Сумма товара',
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
                      value: price,
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PunchingAnimation(
                      child: GestureDetector(
                        onTap: () async {
                          if(quantity != 1) {
                            for(ItemCartResponseModel a in marketplaceProvider.userCart?.items ?? []) {
                              if(a.productId == product?.id) {
                                setState(() {
                                  a.quantity = a.quantity! - 1;
                                });
                                break;
                              }
                            }
                            await marketplaceProvider.changeItemQuantityInCart(productId, -1);
                          }
                          else {
                            for(ItemCartResponseModel a in marketplaceProvider.userCart?.items ?? []) {
                              if(a.productId == product?.id) {
                                setState(() {
                                  a.quantity = a.quantity! - 1;
                                });
                                break;
                              }
                            }
                            popupAlertWidget(
                              title: 'Удалить товар из корзины',
                              subtitle: 'Вы удалите 1 позицию в корзине',
                              context: context,
                              onCancel: () => Navigator.pop(context),
                              onAgree: () async {
                                await marketplaceProvider.removeProductFromBasket(productId);
                                Navigator.pop(context);
                              },
                            );
                          }
                          await marketplaceProvider.bounceCart();
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Image.asset(
                          ConstantsAssets.removeFromBasket,
                          height: 4.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Center(
                      child: AnimatedFlipCounter(
                        suffix: ' шт',
                        value: quantity,
                        duration: const Duration(
                          milliseconds: 200,
                        ),
                        textStyle: TextStyle(
                          color: const Color.fromRGBO(32, 30, 31, 1),
                          fontSize: 11.5.sp,
                          fontFamily: ConstantsFonts.latoSemiBold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    PunchingAnimation(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            for(ItemCartResponseModel a in marketplaceProvider.userCart?.items ?? []) {
                              if(a.productId == product?.id) {
                                setState(() {
                                  a.quantity = a.quantity! + 1;
                                });
                                break;
                              }
                            }
                          });
                          await marketplaceProvider.changeItemQuantityInCart(productId, 1);
                          await marketplaceProvider.bounceCart();
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Image.asset(
                          ConstantsAssets.productAddImage,
                          height: 4.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Positioned(
        bottom: 1.5.h,
        right: 3.w,
        left: 3.w,
        child: FadeInUp(
          duration: const Duration(
            milliseconds: 600,
          ),
          delay: const Duration(
            milliseconds: 200,
          ),
          child: MainButton(
            activeColor: const Color.fromRGBO(87, 167, 109, 1),
            text: widget.state == MarketplaceProductType.products ?
            'КУПИТЬ' :
            'ЗАКАЗТЬ УСЛУГУ',
            textStyle: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: 10.5.sp,
              fontFamily: ConstantsFonts.latoBlack,
            ),
            onTap: () {
              marketplaceProvider.addProductToBasket(product?.id ?? 0, (model) {
                if(model != null) {
                  if(model.status == true) {
                    marketplaceProvider.getUserCart();
                  }
                }
              });
              marketplaceProvider.addingProductWidget(
                context: context,
                added: 1,
                onCancel: () {},
                onAgree: () async {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(
                    reason: SnackBarClosedReason.swipe,
                  );
                  Timer(
                    const Duration(
                      milliseconds: 450,
                    ),
                    (() {
                      Navigator.push(
                        context,
                        verticalSoftNavigation(
                          const ShoppingCartScreen(),
                        ),
                      );
                    }),
                  );
                },
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    final ProductDataResponseModel? product = marketplaceProvider.product;
    return MarketplaceAppBar(
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: SafeArea(
          child: BootEngine(
            loadValue: marketplaceProvider.productLoading,
            activeFlow: Stack(
              children: [
                ListView(
                  controller: pageController,
                  physics: platformScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              verticalSoftNavigation(
                                FullScreenGalleryMarket(
                                  gallery: product?.gallery ?? [],
                                  initialIndex: page,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 48.h,
                            child: CarouselSlider(
                              items: List.generate(product?.gallery?.length ?? 0, (index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 0.5.w,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: product?.gallery?[index].url ?? '',
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width: double.infinity,
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    errorWidget: (context, error, widget) {
                                      return Container(
                                        width: double.infinity,
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              ConstantsAssets.memorialBookLogoImage,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    progressIndicatorBuilder: (context, url, downloadProgress) {
                                      return SkeletonLoaderWidget(
                                        width: 42.w,
                                        height: 11.3.h,
                                        borderRadius: 5,
                                      );
                                    },
                                  ),
                                );
                              }),
                              options: CarouselOptions(
                                onPageChanged: (value, _) => setState(() => page = value),
                                enlargeCenterPage: true,
                                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                                viewportFraction: 0.94,
                                enlargeFactor: 0.1,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          left: 0,
                          bottom: 3.4.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              product?.gallery?.length ?? 0,
                              ((index) => Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.w,
                                ),
                                child: IndicatorProductGallery(
                                  isActive: page == index,
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            product?.name ?? '',
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
                            'US \$${product?.price}',
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
                            widget.state == MarketplaceProductType.products ?
                            'Описание / Состав' :
                            'Описание',
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
                            product?.description ?? '',
                            style: TextStyle(
                              fontFamily: ConstantsFonts.latoRegular,
                              fontSize: 9.5.sp,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            'Дополнительные параметры',
                            style: TextStyle(
                              fontFamily: ConstantsFonts.latoSemiBold,
                              fontSize: 15.5.sp,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          if(product?.options?.size != null) Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Размеры',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoSemiBold,
                                  fontSize: 11.5.sp,
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                              Text(
                                'В ширину ${product?.options?.size?.width} ${product?.options?.size?.unit}\nВ длину ${product?.options?.size?.height} ${product?.options?.size?.unit}',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 9.5.sp,
                                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                            ],
                          ),
                          if(product?.options?.color != null) Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Цвет',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoSemiBold,
                                  fontSize: 11.5.sp,
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                              Text(
                                product?.options?.color ?? 'Любой',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 9.5.sp,
                                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                            ],
                          ),
                          if(product?.options?.manufacturingTime != null) Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.state == MarketplaceProductType.products ?
                                'Время изготовления' :
                                'Время исполнения услуги',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoSemiBold,
                                  fontSize: 11.5.sp,
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                              Text(
                                '${product?.options?.manufacturingTime?.value} минут',
                                style: TextStyle(
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 9.5.sp,
                                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                            ],
                          ),
                          widget.state == MarketplaceProductType.products ?
                          MainButton(
                            activeColor: const Color.fromRGBO(225, 228, 231, 1),
                            text: 'Заказать возложение',
                            onTap: () {},
                            textStyle: TextStyle(
                              color: const Color.fromRGBO(32, 30, 31, 1),
                              fontSize: 10.5.sp,
                              fontFamily: ConstantsFonts.latoBlack,
                            ),
                          ) :
                          const SizedBox(),
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
                            'Другие ${widget.state == MarketplaceProductType.products ?
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
                          // SizedBox(
                          //   height: 30.h,
                          //   child: ListView.builder(
                          //     physics: const BouncingScrollPhysics(),
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) {
                          //       final ItemModel modelOther = state == MarketplaceState.products ?
                          //       marketplaceProvider.products[index] :
                          //       marketplaceProvider.services[index];
                          //       if(modelOther == model) {
                          //         return const SizedBox();
                          //       } else {
                          //         return Padding(
                          //           padding: EdgeInsets.symmetric(
                          //             horizontal: 1.w,
                          //           ),
                          //           child: VerticalProductCard(
                          //             symbol: ConstantsAssets.symbolProductImage,
                          //             width: 38.w,
                          //             model: modelOther,
                          //           ),
                          //         );
                          //       }
                          //     },
                          //     itemCount: state == MarketplaceState.products ?
                          //     marketplaceProvider.products.length :
                          //     marketplaceProvider.services.length,
                          //   ),
                          // ),
                          SizedBox(
                            height: 8.6.h,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                if(widget.state == MarketplaceProductType.products)
                price(),
              ],
            ),
            loadingFlow: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SkeletonLoaderWidget(
                    height: 48.h,
                    width: double.infinity,
                    borderRadius: 20,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLoaderWidget(
                        height: 3.4.h,
                        width: 20.w,
                        borderRadius: 10,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SkeletonLoaderWidget(
                        height: 3.h,
                        width: 30.w,
                        borderRadius: 10,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SkeletonLoaderWidget(
                        height: 3.h,
                        width: 44.w,
                        borderRadius: 10,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      SkeletonLoaderWidget(
                        height: 2.h,
                        width: 76.w,
                        borderRadius: 10,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SkeletonLoaderWidget(
                        height: 2.h,
                        width: 88.w,
                        borderRadius: 10,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SkeletonLoaderWidget(
                        height: 2.h,
                        width: 30.w,
                        borderRadius: 10,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      SkeletonLoaderWidget(
                        height: 7.h,
                        width: double.infinity,
                        borderRadius: 7,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}