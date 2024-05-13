import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/models/market/item_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/constants.dart';
import '../../provider/marketplace_provider.dart';
import '../animation/punching_animation.dart';
import '../skeleton_loader_widget.dart';

class ProductCardShoppingCart extends StatefulWidget {
  const ProductCardShoppingCart({
    super.key,
    required this.model,
  });

  final ItemModel model;

  @override
  State<ProductCardShoppingCart> createState() => _ProductCardShoppingCartState();
}

class _ProductCardShoppingCartState extends State<ProductCardShoppingCart> {

  double totalPrice() {
    double convertPriceToDouble = double.parse(widget.model.price.replaceAll(',', '.'));
    double convertedTotalPrice = convertPriceToDouble * widget.model.numberOfAdded;
    return convertedTotalPrice;
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
            imageUrl: widget.model.avatar,
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
                  widget.model.productName,
                  style: TextStyle(
                    color: const Color.fromRGBO(32, 30, 31, 1),
                    fontSize: 15.5.sp,
                    fontFamily: ConstantsFonts.latoSemiBold,
                  ),
                ),
                if(widget.model.cashback != null) Column(
                  children: [
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.model.cashback ?? '',
                      style: TextStyle(
                        color: const Color.fromRGBO(32, 30, 31, 1),
                        fontFamily: ConstantsFonts.latoRegular,
                        fontSize: 9.5.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedFlipCounter(
                      prefix: 'US \$',
                      value: totalPrice(),
                      fractionDigits: 2,
                      duration: const Duration(
                        milliseconds: 200,
                      ),
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(32, 30, 31, 1),
                        fontSize: 15.5.sp,
                        fontFamily: ConstantsFonts.latoBold,
                      ),
                    ),
                    // Text(
                    //   'US \$${totalPrice()}',
                    //   style: TextStyle(
                    //     color: const Color.fromRGBO(32, 30, 31, 1),
                    //     fontSize: 15.5.sp,
                    //     fontFamily: ConstantsFonts.latoBold,
                    //   ),
                    // ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PunchingAnimation(
                          child: GestureDetector(
                            onTap: () => marketplaceProvider.removeItem(widget.model),
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
                              widget.model.numberOfAdded.toString(),
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
                            onTap: () => marketplaceProvider.addItem(widget.model),
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
