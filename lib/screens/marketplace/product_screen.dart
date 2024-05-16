import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/provider/marketplace_provider.dart';
import 'package:memorial_book/screens/marketplace/product_card_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/boot_engine.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:memorial_book/widgets/marketplace_widgets/max_vertical_product_card.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../helpers/enums.dart';
import '../../models/market/response/products_response_models/product_data_response_model.dart';
import '../../widgets/search_engine.dart';
import '../../widgets/skeleton_loader_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  @override
  void initState() {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await marketplaceProvider.getProductsCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    return MarketplaceAppBar(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
          ),
          child: BootEngine(
            loadValue: marketplaceProvider.productsCategoryLoading,
            // loadValue: true,
            activeFlow: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 2.2.h,
                ),
                Text(
                  'Товары',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoSemiBold,
                    fontSize: 18.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                SizedBox(
                  height: 2.2.h,
                ),
                Column(
                  children: [
                    Row(
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
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.h,
                    crossAxisSpacing: 1.6.w,
                    mainAxisExtent: 30.2.h,
                  ),
                  itemCount: marketplaceProvider.productsCategoryModel?.productsData?.length ?? 0,
                  itemBuilder: (context, index) {
                    final ProductDataResponseModel model = marketplaceProvider.productsCategoryModel!.productsData![index];
                    return PunchingAnimation(
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const ProductCardScreen(
                                state: MarketplaceState.products,
                              ),
                            ),
                          );
                          await marketplaceProvider.getProductById(model.id ?? 0);
                        },
                        child: MaxVerticalProductCard(
                          symbol: ConstantsAssets.symbolProductImage,
                          model: model,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
            loadingFlow: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 2.2.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoaderWidget(
                      height: 4.h,
                      width: 22.w,
                      borderRadius: 10,
                    ),
                    SizedBox(
                      height: 2.2.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SkeletonLoaderWidget(
                            height: 6.3.h,
                            width: double.infinity,
                            borderRadius: 5,
                          ),
                        ),
                        SizedBox(
                          width: 2.5.w,
                        ),
                        SkeletonLoaderWidget(
                          height: 6.3.h,
                          width: 6.3.h,
                          borderRadius: 5,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.h,
                    crossAxisSpacing: 1.6.w,
                    mainAxisExtent: 30.2.h,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SkeletonLoaderWidget(
                      height: 30.2.h,
                      width: 38.w,
                      borderRadius: 10,
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
