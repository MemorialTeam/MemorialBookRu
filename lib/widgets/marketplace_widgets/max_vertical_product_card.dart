import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/enums.dart';
import '../../models/market/response/item_cart_response_model.dart';
import '../../models/market/response/products_response_models/product_data_response_model.dart';
import '../../provider/marketplace_provider.dart';
import '../skeleton_loader_widget.dart';

class MaxVerticalProductCard extends StatefulWidget {
  const MaxVerticalProductCard({
    super.key,
    required this.model,
    this.symbol,
    this.width,
    required this.state,
  });

  final ProductDataResponseModel model;
  final String? symbol;

  final double? width;

  final MarketplaceProductType state;

  @override
  State<MaxVerticalProductCard> createState() => _MaxVerticalProductCardState();
}

class _MaxVerticalProductCardState extends State<MaxVerticalProductCard> {

  bool buttonLoading = false;

  Widget check() {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    bool checkInCart = false;
    int quantity = 0;
    int productId = 0;
    for(ItemCartResponseModel a in marketplaceProvider.userCart?.items ?? []) {
      if(a.productId == widget.model.id) {
        checkInCart = true;
        quantity = a.quantity ?? 0;
        productId = a.id ?? 0;
        break;
      } else {
        checkInCart = false;
      }
    }
    return Container(
      height: 5.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: checkInCart == false ?
        const Color.fromRGBO(87, 167, 109, 1) :
        Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromRGBO(87, 167, 109, 1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: checkInCart == false ?
          (() async {
            setState(() => buttonLoading = true);
            await marketplaceProvider.addProductToBasket(
              widget.model.id ?? 0,
              ((model) {
                if(model != null) {
                  if(model.status == true) {
                    marketplaceProvider.getUserCart().whenComplete(
                      (() => setState(() => buttonLoading = false)),
                    );
                  }
                }
              }),
            );
          }) :
          null,
          child: Center(
            child: checkInCart == false ?
            buttonLoading == false ?
            Text(
              'В корзину',
              style: TextStyle(
                fontSize: 9.5.sp,
                color: Colors.white,
                fontFamily: ConstantsFonts.latoBold,
              ),
            ) :
            SizedBox(
              height: 3.h,
              width: 3.h,
              child: const LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
                colors: [
                  Colors.white,
                ],
              ),
            ) :
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PunchingAnimation(
                  child: GestureDetector(
                    onTap: () async {
                      if(quantity != 1) {
                        for(ItemCartResponseModel a in marketplaceProvider.userCart?.items ?? []) {
                          if(a.productId == widget.model.id) {
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
                          if(a.productId == widget.model.id) {
                            setState(() {
                              marketplaceProvider.userCart!.items!.remove(a);
                              a.quantity = a.quantity! - 1;
                            });
                            break;
                          }
                        }
                        await marketplaceProvider.removeProductFromBasket(productId);
                      }
                      await marketplaceProvider.bounceCart();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Image.asset(
                      ConstantsAssets.removeFromBasket,
                      height: 3.3.h,
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
                      fontSize: 10.5.sp,
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
                      for(ItemCartResponseModel a in marketplaceProvider.userCart?.items ?? []) {
                        if(a.productId == widget.model.id) {
                          setState(() {
                            a.quantity = a.quantity! + 1;
                          });
                          break;
                        }
                      }
                      await marketplaceProvider.changeItemQuantityInCart(productId, 1);
                      await marketplaceProvider.bounceCart();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Image.asset(
                      ConstantsAssets.productAddImage,
                      height: 3.3.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget price() {
    if(widget.model.discountedPrice != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'US \$${widget.model.price}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red,
              fontFamily: ConstantsFonts.latoRegular,
              fontSize: 7.5.sp,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          Text(
            'US \$${widget.model.discountedPrice}',
            style: TextStyle(
              fontFamily: ConstantsFonts.latoRegular,
              fontSize: 9.5.sp,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          )
        ],
      );
    } else {
      return Text(
        'US \$${widget.model.price}',
        style: TextStyle(
          fontFamily: ConstantsFonts.latoRegular,
          fontSize: 9.5.sp,
          color: const Color.fromRGBO(0, 0, 0, 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: widget.model.mainPhoto ?? '',
                width: double.infinity,
                imageBuilder: (context, image) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                },
                placeholder: (context, loading) {
                  return const SkeletonLoaderWidget(
                    height: double.infinity,
                    width: double.infinity,
                    borderRadius: 5,
                  );
                },
                errorWidget: (context, error, _) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ConstantsAssets.memorialBookLogoImage),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 1.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.name ?? '',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoBold,
                    fontSize: 11.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    height: 0.7.sp,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                price(),
              ],
            ),
          ),
          if(widget.state == MarketplaceProductType.products)
          SizedBox(
            height: 1.h,
          ),
          if(widget.state == MarketplaceProductType.products)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                ),
                child: check(),
              ),
            ),
        ],
      ),
    );
  }
}
