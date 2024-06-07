import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/models/market/item_model.dart';
import 'package:sizer/sizer.dart';

import '../../models/market/response/products_response_models/get_products_category_response_model.dart';
import '../../models/market/response/products_response_models/product_data_response_model.dart';
import '../skeleton_loader_widget.dart';

class VerticalProductCard extends StatefulWidget {
  const VerticalProductCard({
    super.key,
    required this.model,
    this.symbol,
    this.width,
  });

  final ProductDataResponseModel? model;
  final String? symbol;

  final double? width;

  @override
  State<VerticalProductCard> createState() => _VerticalProductCardState();
}

class _VerticalProductCardState extends State<VerticalProductCard> {

  Widget price() {
    if(widget.model?.discountedPrice != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'US \$${widget.model?.price ?? 0}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red,
              fontFamily: ConstantsFonts.latoRegular,
              fontSize: 7.5.sp,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          Text(
            'US \$${widget.model?.discountedPrice ?? 0}',
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
        'US \$${widget.model?.price ?? 0}',
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
          CachedNetworkImage(
            height: 20.h,
            width: double.infinity,
            imageUrl: widget.model?.mainPhoto ?? '',
            imageBuilder: (context, image) {
              return Container(
                padding: EdgeInsets.all(1.h),
                alignment: Alignment.bottomRight,
                height: 20.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: widget.symbol != null ?
                Image.asset(
                  widget.symbol!,
                  height: 4.h,
                ) :
                null,
              );
            },
            errorWidget: (context, indicator, error) {
              return Container(
                height: 20.h,
                width: double.infinity,
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
                height: 20.h,
                width: double.infinity,
                borderRadius: 5,
              );
            },
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 1.6.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model?.name ?? '',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoBold,
                    fontSize: 11.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    height: 0.8.sp
                  ),
                ),
                SizedBox(
                  height: 0.6.h,
                ),
                price(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
