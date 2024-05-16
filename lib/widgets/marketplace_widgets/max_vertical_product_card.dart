import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/market/response/products_response_models/product_data_response_model.dart';
import '../../provider/marketplace_provider.dart';
import '../skeleton_loader_widget.dart';

class MaxVerticalProductCard extends StatelessWidget {
  const MaxVerticalProductCard({
    super.key,
    required this.model,
    this.symbol,
    this.width,
  });

  final ProductDataResponseModel model;
  final String? symbol;

  final double? width;

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);

    Widget price() {
      if(model.discountedPrice != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'US \$${model.price}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.red,
                fontFamily: ConstantsFonts.latoRegular,
                fontSize: 7.5.sp,
                color: const Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
            Text(
              'US \$${model.discountedPrice}',
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
          'US \$${model.price}',
          style: TextStyle(
            fontFamily: ConstantsFonts.latoRegular,
            fontSize: 9.5.sp,
            color: const Color.fromRGBO(0, 0, 0, 1),
          ),
        );
      }
    }

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: model.mainPhoto ?? '',
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
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(5),
          //   child: Image.asset(
          //     model.avatar,
          //     width: double.infinity,
          //   ),
          // ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 1.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name ?? '',
                      style: TextStyle(
                        fontFamily: ConstantsFonts.latoBold,
                        fontSize: 11.5.sp,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    price(),
                  ],
                ),
                PunchingAnimation(
                  child: GestureDetector(
                    onTap: () => marketplaceProvider.addItem(model),
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: EdgeInsets.all(1.w),
                      child: Image.asset(
                        ConstantsAssets.productAddImage,
                        height: 3.6.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
