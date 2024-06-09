import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../provider/marketplace_provider.dart';
import '../../screens/marketplace/product_screen.dart';
import '../../screens/marketplace/services_screen.dart';
import '../skeleton_loader_widget.dart';
import 'category_card.dart';

class CategoryFlow extends StatefulWidget {
  const CategoryFlow({super.key});

  @override
  State<CategoryFlow> createState() => _CategoryFlowState();
}

class _CategoryFlowState extends State<CategoryFlow> {

  Widget products() {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    if(marketplaceProvider.productsMainLoading == true) {
      return Expanded(
        child: SkeletonLoaderWidget(
          height: 24.h,
          width: double.infinity,
          borderRadius: 10,
        ),
      );
    }
    else if(marketplaceProvider.productsMainModel?.productsData != null && marketplaceProvider.productsMainModel!.productsData!.isNotEmpty) {
      return Expanded(
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
      );
    } else {
      return const SizedBox();
    }
  }
  Widget services() {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    if(marketplaceProvider.servicesMainLoading == true) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            left: 1.w,
          ),
          child: SkeletonLoaderWidget(
            height: 24.h,
            width: double.infinity,
            borderRadius: 10,
          ),
        ),
      );
    } else if(marketplaceProvider.servicesMainModel?.productsData != null && marketplaceProvider.servicesMainModel!.productsData!.isNotEmpty) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            left: 1.w,
          ),
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
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        products(),
        services(),
      ],
    );
  }
}
