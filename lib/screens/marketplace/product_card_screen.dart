import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/boot_engine.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:memorial_book/widgets/skeleton_loader_widget.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../helpers/enums.dart';
import '../../models/market/response/products_response_models/product_data_response_model.dart';
import '../../provider/marketplace_provider.dart';

class ProductCardScreen extends StatelessWidget {
  const ProductCardScreen({
    super.key,
    required this.state,
  });

  final MarketplaceState state;

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    final ProductDataResponseModel product = marketplaceProvider.product!;
    return MarketplaceAppBar(
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
            ),
            child: BootEngine(
              loadValue: marketplaceProvider.productLoading,
              activeFlow: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 48.h,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          ConstantsAssets.testProductImage,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    product.name ?? '',
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
                    'US \$${product.price}',
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
                    'Описание / Состав',
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
                    product.description ?? '',
                    style: TextStyle(
                      fontFamily: ConstantsFonts.latoRegular,
                      fontSize: 9.5.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  MainButton(
                    activeColor: const Color.fromRGBO(87, 167, 109, 1),
                    text: 'КУПИТЬ',
                    textStyle: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 10.5.sp,
                      fontFamily: ConstantsFonts.latoBlack,
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  MainButton(
                    activeColor: const Color.fromRGBO(225, 228, 231, 1),
                    text: 'Заказать возложение',
                    onTap: () {},
                    textStyle: TextStyle(
                      color: const Color.fromRGBO(32, 30, 31, 1),
                      fontSize: 10.5.sp,
                      fontFamily: ConstantsFonts.latoBlack,
                    ),
                  ),
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
                    'Другие ${state == MarketplaceState.products ?
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
                ],
              ),
              loadingFlow: ListView(
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