import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../models/market/product_model.dart';
import '../../models/market/status_product_card.dart';
import '../skeleton_loader_widget.dart';

class ProductFromHistoryCard extends StatefulWidget {
  const ProductFromHistoryCard({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductFromHistoryCard> createState() => _ProductFromHistoryCardState();
}

class _ProductFromHistoryCardState extends State<ProductFromHistoryCard> {

  late StatusProductCard statusProductCard;

  void status() {
    switch(widget.model.status) {
      case 'Новый':
        statusProductCard = StatusProductCard(
          color: const Color.fromRGBO(255, 163, 24, 1),
          title: 'Новый',
        );
        break;
      case 'В работе':
        statusProductCard = StatusProductCard(
          color: const Color.fromRGBO(23, 94, 217, 1),
          title: 'В работе',
        );
        break;
      case 'Выполнен':
        statusProductCard = StatusProductCard(
          color: const Color.fromRGBO(18, 175, 82, 1),
          title: 'Выполнен',
        );
        break;
      case 'Отменен':
        statusProductCard = StatusProductCard(
          color: const Color.fromRGBO(235, 87, 87, 1),
          title: 'Отменен',
        );
        break;
      default:
        statusProductCard = StatusProductCard(
          color: const Color.fromRGBO(23, 94, 217, 1),
          title: 'В работе',
        );
        break;
    }
  }

  @override
  void initState() {
    status();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PunchingAnimation(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 1.6.h,
            horizontal: 3.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    height: 12.h,
                    width: 12.h,
                    imageUrl: widget.model.image,
                    imageBuilder: (context, image) {
                      return Container(
                        height: 12.h,
                        width: 12.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                  SizedBox(
                    width: 46.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 1.w,
                            vertical: 0.3.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: statusProductCard.color,
                          ),
                          child: Text(
                            statusProductCard.title,
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: ConstantsFonts.latoRegular,
                              fontSize: 7.5.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          widget.model.productName,
                          style: TextStyle(
                            color: const Color.fromRGBO(32, 30, 31, 1),
                            fontSize: 15.5.sp,
                            fontFamily: ConstantsFonts.latoSemiBold,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          'US \$${widget.model.price}',
                          style: TextStyle(
                            color: const Color.fromRGBO(32, 30, 31, 1),
                            fontSize: 15.5.sp,
                            fontFamily: ConstantsFonts.latoSemiBold,
                          ),
                        ),
                        if(widget.model.cashback != null) Text(
                          widget.model.cashback ?? '',
                          style: TextStyle(
                            color: const Color.fromRGBO(32, 30, 31, 1),
                            fontFamily: ConstantsFonts.latoRegular,
                            fontSize: 9.5.sp,
                          ),
                        ),
                        if(widget.model.status == 'Выполнен') PunchingAnimation(
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 0.5.h,
                              ),
                              child: Text(
                                'Повторить заказ?',
                                style: TextStyle(
                                  color: const Color.fromRGBO(23, 94, 217, 1),
                                  fontFamily: ConstantsFonts.latoRegular,
                                  fontSize: 9.5.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                widget.model.doneAt,
                style: TextStyle(
                  color: const Color.fromRGBO(32, 30, 31, 1),
                  fontSize: 7.5.sp,
                  fontFamily: ConstantsFonts.latoRegular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
