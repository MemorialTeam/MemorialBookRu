import 'dart:async';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../models/market/response/item_cart_response_model.dart';
import '../../provider/marketplace_provider.dart';
import '../animation/punching_animation.dart';
import '../element_selection/popupAlertWidget.dart';
import '../skeleton_loader_widget.dart';

class ProductCardShoppingCart extends StatefulWidget {
  const ProductCardShoppingCart({
    super.key,
    required this.model,
  });

  final ItemCartResponseModel model;

  @override
  State<ProductCardShoppingCart> createState() => _ProductCardShoppingCartState();
}

class _ProductCardShoppingCartState extends State<ProductCardShoppingCart> {

  Widget price() {
    if(widget.model.totalDiscountPrice != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedFlipCounter(
            prefix: 'US \$',
            value: widget.model.price!,
            fractionDigits: 2,
            duration: const Duration(
              milliseconds: 200,
            ),
            textStyle: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: const Color.fromRGBO(32, 30, 31, 1),
              decorationColor: Colors.red,
              // decorationStyle: TextDecorationStyle.solid,
              fontSize: 9.5.sp,
              height: 0.8.sp,
              fontFamily: ConstantsFonts.latoBold,
            ),
          ),
          AnimatedFlipCounter(
            prefix: 'US \$',
            value: widget.model.totalDiscountPrice ?? 0,
            fractionDigits: 2,
            duration: const Duration(
              milliseconds: 200,
            ),
            textStyle: TextStyle(
              color: const Color.fromRGBO(32, 30, 31, 1),
              fontSize: 15.5.sp,
              height: 0.8.sp,
              fontFamily: ConstantsFonts.latoBold,
            ),
          ),
        ],
      );
    } else {
      return AnimatedFlipCounter(
        prefix: 'US \$',
        value: widget.model.price ?? 0,
        fractionDigits: 2,
        duration: const Duration(
          milliseconds: 200,
        ),
        textStyle: TextStyle(
          color: const Color.fromRGBO(32, 30, 31, 1),
          fontSize: 15.5.sp,
          fontFamily: ConstantsFonts.latoBold,
        ),
      );
    }
  }
  Timer? _debounce;
  Future<void> bounceCart() async {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(
      context,
      listen: false,
    );
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      return await marketplaceProvider.getUserCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 1.6.h,
        horizontal: 3.w,
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            height: 12.h,
            width: 12.h,
            imageUrl: widget.model.avatar ?? 'https://static-01.daraz.lk/p/53fd0b6aebc9eff7acbee04a4389c77b.jpg',
            imageBuilder: (context, image) {
              return Container(
                height: 12.h,
                width: 12.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                  ),
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            errorWidget: (context, indicator, error) {
              return Container(
                height: 12.h,
                width: 12.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(
                      ConstantsAssets.memorialBookLogoImage,
                    ),
                  ),
                ),
              );
            },
            placeholder: (context, indicator) {
              return SkeletonLoaderWidget(
                height: 12.h,
                width: 12.h,
                borderRadius: 10,
              );
            },
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.model.name ?? '',
                  style: TextStyle(
                    color: const Color.fromRGBO(32, 30, 31, 1),
                    fontSize: 15.5.sp,
                    fontFamily: ConstantsFonts.latoSemiBold,
                  ),
                ),
                // if(widget.model.discountedPrice != null) Column(
                //   children: [
                //     SizedBox(
                //       height: 0.5.h,
                //     ),
                //     Text(
                //       widget.model.discountedPrice.toString() ?? '',
                //       style: TextStyle(
                //         color: const Color.fromRGBO(32, 30, 31, 1),
                //         fontFamily: ConstantsFonts.latoRegular,
                //         fontSize: 9.5.sp,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 1.6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    price(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PunchingAnimation(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if(widget.model.quantity! != 1) {
                                  widget.model.quantity = widget.model.quantity! - 1;
                                  marketplaceProvider.changeItemQuantityInCart(widget.model.id ?? 0, -1);
                                }
                                else {
                                  popupAlertWidget(
                                    title: 'Удалить товар из корзины',
                                    subtitle: 'Вы удалите 1 позицию в корзине',
                                    context: context,
                                    onCancel: () => Navigator.pop(context),
                                    onAgree: () {
                                      marketplaceProvider.userCart!.items!.remove(widget.model);
                                      marketplaceProvider.removeProductFromBasket(widget.model.id ?? 0);
                                      Navigator.pop(context);
                                    },
                                  );
                                }
                                bounceCart();
                              });
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Image.asset(
                              ConstantsAssets.removeFromCardImage,
                              height: 4.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        SizedBox(
                          width: 6.4.w,
                          child: Center(
                            child: Text(
                              widget.model.quantity!.toString(),
                              style: TextStyle(
                                color: const Color.fromRGBO(32, 30, 31, 1),
                                fontSize: 11.5.sp,
                                fontFamily: ConstantsFonts.latoBold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        PunchingAnimation(
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                widget.model.quantity = widget.model.quantity! + 1;
                              });
                              await marketplaceProvider.changeItemQuantityInCart(widget.model.id ?? 0, 1);
                              bounceCart();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Image.asset(
                              ConstantsAssets.addToCardImage,
                              height: 4.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
