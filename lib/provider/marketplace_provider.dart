import 'dart:async';
import 'package:http/http.dart';

import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:sizer/sizer.dart';
import '../data_handler/mapper.dart';
import '../data_handler/service.dart';
import '../models/common/status_response_model.dart';
import '../models/market/response/get_shop_response_model.dart';
import '../models/market/response/item_cart_response_model.dart';
import '../models/market/response/products_response_models/get_products_category_response_model.dart';
import '../models/market/response/products_response_models/product_data_response_model.dart';
import '../models/market/response/user_cart_response_model.dart';

class MarketplaceProvider extends ChangeNotifier {
  int currentPost = 0;

  final service = Service();
  final mapper = Mapper();

  void onPageChanged(int page, CarouselPageChangedReason controller) {
    currentPost = page;
    notifyListeners();
  }

  List<ProductDataResponseModel> basket = [];

  void addItem(ProductDataResponseModel item) {
    if(basket.contains(item) == false) {
      basket.add(item);
      notifyListeners();
    }
    item.numberOfAdded++;
    notifyListeners();
  }

  int grandTotal() {
    int price = 0;
    for(ItemCartResponseModel i in userCart!.items!) {
      price = price + i.totalDiscountPrice!;
    }
    return price;
  }

  GetShopResponseModel? shopModel;

  GetProductsCategoryResponseModel? productsCategoryModel;
  final FocusNode productsCategoryFocusNode = FocusNode();
  final TextEditingController productsCategoryTextEditingController = TextEditingController();
  bool productsCategoryLoading = false;
  bool productsCategoryPaginationLoading = false;
  bool productsCategorySearchLoading = false;
  int productsCategoryPageNumber = 1;
  int productsCategoryLastPageNumber = 1;
  String searchProductsCategoryValue = '';

  Future getProductsCategory() async {
    productsCategoryTextEditingController.clear();
    productsCategoryFocusNode.unfocus();
    searchProductsCategoryValue = '';
    productsCategoryPageNumber = 1;
    productsCategoryModel = null;
    productsCategoryLoading = true;
    notifyListeners();
    await service.getProductsCategoryRequest(productsCategoryPageNumber, 1, null, (response) {
      productsCategoryLoading = false;
      notifyListeners();
      mapper.getProductsCategoryResponse(response, (model) {
        print(response?.body);
        if(model != null) {
          if(model.status == true) {
            productsCategoryModel = model;
            productsCategoryLastPageNumber = model.lastPage ?? 1;
            notifyListeners();
          }
        }
      });
    });
  }
  Future updateProductsCategory() async {
    searchProductsCategoryValue = '';
    productsCategoryPageNumber = 1;
    productsCategoryModel = null;
    productsCategorySearchLoading = true;
    notifyListeners();
    await service.getProductsCategoryRequest(productsCategoryPageNumber, 1, null, (response) {
      productsCategorySearchLoading = false;
      notifyListeners();
      mapper.getProductsCategoryResponse(response, (model) {
        print(response?.body);
        if(model != null) {
          if(model.status == true) {
            productsCategoryModel = model;
            productsCategoryLastPageNumber = model.lastPage ?? 1;
            notifyListeners();
          }
        }
      });
    });
  }
  Future searchProductsCategory(String name) async {
    searchProductsCategoryValue = name;
    productsCategoryLastPageNumber = 1;
    productsCategoryPageNumber = 1;
    productsCategoryModel = null;
    productsCategorySearchLoading = true;
    notifyListeners();
    await service.getProductsCategoryRequest(productsCategoryPageNumber, 1, searchProductsCategoryValue,(response) {
      mapper.getProductsCategoryResponse(response, (model) {
        productsCategorySearchLoading = false;
        notifyListeners();
        print(response?.body);
        if(model != null) {
          if(model.status == true) {
            productsCategoryModel = model;
            productsCategoryLastPageNumber = model.lastPage ?? 1;
            notifyListeners();
          }
        }
      });
    });
  }
  Future paginationProductsCategory() async {
    productsCategoryPageNumber++;
    productsCategoryPaginationLoading = true;
    notifyListeners();
    await service.getProductsCategoryRequest(productsCategoryPageNumber, 1, searchProductsCategoryValue, (response) {
      mapper.getProductsCategoryResponse(response, (model) {
        productsCategoryPaginationLoading = false;
        if(model != null) {
          if(model.status == true) {
            if(model.productsData != null) {
              productsCategoryModel!.productsData!.addAll(model.productsData ?? []);
              notifyListeners();
            }
          }
        }
      });
    });
  }

  GetProductsCategoryResponseModel? servicesCategoryModel;
  final FocusNode servicesCategoryFocusNode = FocusNode();
  final TextEditingController servicesCategoryTextEditingController = TextEditingController();
  bool servicesCategoryLoading = false;
  bool servicesCategoryPaginationLoading = false;
  bool servicesCategorySearchLoading = false;
  int servicesCategoryPageNumber = 1;
  int servicesCategoryLastPageNumber = 1;
  String searchServicesCategoryValue = '';

  Future getServicesCategory() async {
    servicesCategoryTextEditingController.clear();
    servicesCategoryFocusNode.unfocus();
    searchProductsCategoryValue = '';
    servicesCategoryPageNumber = 1;
    servicesCategoryModel = null;
    servicesCategoryLoading = true;
    notifyListeners();
    await service.getServicesCategoryRequest(servicesCategoryPageNumber, 1, null, (response) {
      mapper.getProductsCategoryResponse(response, (model) {
        servicesCategoryLoading = false;
        notifyListeners();
        print(response?.body);
        if(model != null) {
          if(model.status == true) {
            servicesCategoryModel = model;
            servicesCategoryLastPageNumber = model.lastPage ?? 1;
            notifyListeners();
          }
        }
      });
    });
  }
  Future updateServicesCategory() async {
    servicesCategorySearchLoading = true;
    searchProductsCategoryValue = '';
    servicesCategoryPageNumber = 1;
    servicesCategoryModel = null;
    notifyListeners();
    await service.getServicesCategoryRequest(servicesCategoryPageNumber, 1, null, (response) {
      mapper.getProductsCategoryResponse(response, (model) {
        servicesCategorySearchLoading = false;
        notifyListeners();
        print(response?.body);
        if(model != null) {
          if(model.status == true) {
            servicesCategoryModel = model;
            servicesCategoryLastPageNumber = model.lastPage ?? 1;
            notifyListeners();
          }
        }
      });
    });
  }
  Future searchServicesCategory(String name) async {
    searchProductsCategoryValue = name;
    servicesCategoryLastPageNumber = 1;
    servicesCategoryPageNumber = 1;
    servicesCategoryModel = null;
    servicesCategorySearchLoading = true;
    notifyListeners();
    await service.getServicesCategoryRequest(servicesCategoryPageNumber, 1, searchServicesCategoryValue,(response) {
      servicesCategorySearchLoading = false;
      notifyListeners();
      mapper.getProductsCategoryResponse(response, (model) {
        print(response?.body);
        if(model != null) {
          if(model.status == true) {
            servicesCategoryModel = model;
            servicesCategoryLastPageNumber = model.lastPage ?? 1;
            notifyListeners();
          }
        }
      });
    });
  }
  Future paginationServicesCategory() async {
    servicesCategoryPageNumber++;
    servicesCategoryPaginationLoading = true;
    notifyListeners();
    await service.getProductsCategoryRequest(servicesCategoryPageNumber, 1, searchProductsCategoryValue, (response) {
      servicesCategoryPaginationLoading = false;
      notifyListeners();
      mapper.getProductsCategoryResponse(response, (model) {
        if(model != null) {
          if(model.status == true) {
            if(model.productsData != null) {
              servicesCategoryModel!.productsData!.addAll(model.productsData ?? []);
              notifyListeners();
            }
          }
        }
      });
    });
  }

  GetProductsCategoryResponseModel? productsMainModel;
  bool productsMainLoading = false;
  bool productsMainPaginationLoading = false;
  int productsMainPageNumber = 1;
  int productsMainLastPageNumber = 1;

  int marketPlaceId = 14;

  Future getProductsMain() async {
    productsMainPageNumber = 1;
    productsMainModel = null;
    productsMainLoading = true;
    notifyListeners();
    await service.getProductsCategoryRequest(productsMainPageNumber, marketPlaceId, null, (response) {
      mapper.getProductsCategoryResponse(response, (model) {
        productsMainLoading = false;
        notifyListeners();
        print(response?.body);
        if(model != null) {
          if(model.status == true) {
            productsMainModel = model;
            productsMainLastPageNumber = model.lastPage ?? 1;
            notifyListeners();
          }
        }
      });
    });
  }
  Future paginationProductsMain() async {
    productsMainPageNumber++;
    productsMainPaginationLoading = true;
    notifyListeners();
    SVProgressHUD.show();
    await service.getProductsCategoryRequest(productsMainPageNumber, marketPlaceId, null, (response) {
      mapper.getProductsCategoryResponse(response, (model) {
        SVProgressHUD.dismiss();
        productsMainPaginationLoading = false;
        if(model != null) {
          if(model.status == true) {
            if(model.productsData != null) {
              productsMainModel!.productsData!.addAll(model.productsData ?? []);
              notifyListeners();
            }
          }
        }
      });
    });
  }

  GetProductsCategoryResponseModel? servicesMainModel;
  bool servicesMainLoading = false;
  bool servicesMainPaginationLoading = false;
  int servicesMainPageNumber = 1;
  int servicesMainLastPageNumber = 1;

  Future getServicesMain() async {
    servicesMainPageNumber = 1;
    servicesMainModel = null;
    servicesMainLoading = true;
    notifyListeners();
    await service.getServicesCategoryRequest(productsMainPageNumber, marketPlaceId, '', (response) {
      mapper.getServicesCategoryResponse(response, (model) {
        servicesMainLoading = false;
        notifyListeners();
        print(response?.body);
        if(model != null) {
          print(model);
          if(model.status == true) {
            servicesMainModel = model;
            servicesMainLastPageNumber = model.lastPage ?? 1;
            notifyListeners();
          }
        }
      });
    });
  }
  Future paginationServicesMain() async {
    servicesMainPageNumber++;
    servicesMainPaginationLoading = true;
    notifyListeners();
    SVProgressHUD.show();
    await service.getProductsCategoryRequest(servicesMainPageNumber, marketPlaceId, null, (response) {
      mapper.getProductsCategoryResponse(response, (model) {
        SVProgressHUD.dismiss();
        servicesMainPaginationLoading = false;
        if(model != null) {
          if(model.status == true) {
            if(model.productsData != null) {
              servicesMainModel!.productsData!.addAll(model.productsData ?? []);
              notifyListeners();
            }
          }
        }
      });
    });
  }

  ProductDataResponseModel? product;
  bool productLoading = false;

  Future getProductById(int id) async {
    productLoading = true;
    notifyListeners();
    await service.getProductByIdRequest(id, (response) {
      mapper.getProductByIdResponse(response, (model) {
        print(response?.body);
        productLoading = false;
        notifyListeners();
        if(model != null) {
          if(model.status == true) {
            product = model.product;
            notifyListeners();
          }
        }
      });
    });
  }
  Future getServiceById(int id) async {
    productLoading = true;
    notifyListeners();
    await service.getServiceByIdRequest(id, (response) {
      mapper.getProductByIdResponse(response, (model) {
        print(response?.body);
        productLoading = false;
        notifyListeners();
        if(model != null) {
          if(model.status == true) {
            product = model.product;
            notifyListeners();
          }
        }
      });
    });
  }

  bool shopLoading = false;

  Future getShop(int cemeteryId) async {
    shopModel = null;
    servicesMainModel = null;
    productsMainModel = null;
    shopLoading = true;
    notifyListeners();
    await service.getShopRequest(cemeteryId, (response) {
      mapper.getShopResponse(response, (model) {
        shopLoading = false;
        notifyListeners();
        if(model != null) {
          if(model.status == true) {
            shopModel = model;
            notifyListeners();
          }
        }
      });
    });
  }

  Future addProductToBasket(int productId, ValueSetter<StatusResponseModel?> completion) async {
    await service.addProductToBasketRequest(productId, (response) {
      mapper.statusResponse(response, (model) async {
        if(model != null) {
          completion(model);
        } else {
          completion(null);
        }
      });
    });
  }

  Response? latestResponse;
///prod
  Future changeItemQuantity(int itemId, int quantity) async {
    notifyListeners();
    await service.changeItemQuantityRequest(itemId, quantity, (response) {
      mapper.statusResponse(response, (model) async {
        if(model != null) {
          if(model.status == true) {
            await getUserCart();
          }
        }
      });
    });
  }

  Timer? _debounce;
  Future<void> bounceCart() async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      return await getUserCart();
    });
  }

  bool priceCheckCart = false;

  ///test
  Future changeItemQuantityInCart(int itemId, int quantity) async {
    priceCheckCart = true;
    notifyListeners();
    await service.changeItemQuantityRequest(itemId, quantity, (response) {
      mapper.statusResponse(response, (model) async {
        if(model != null) {
          if(model.status == true) {

          }
        }
      });
    });
  }

  Future removeProductFromBasket(int itemId) async {
    await service.removeProductFromBasketRequest(itemId, (response) {
      mapper.statusResponse(response, (model) async {
        if(model != null) {
          if(model.status == true) {
            await getUserCart();
          }
        }
      });
    });
  }

  UserCartResponseModel? userCart;

  Future getUserCart() async {
    await service.getUserCartRequest((response) {
      mapper.getUserCartResponse(response, (model) {
        priceCheckCart = false;
        notifyListeners();
        if(model != null) {
          if(model.status == true) {
            userCart = model;
            notifyListeners();
          } else {
            userCart = null;
            notifyListeners();
          }
        }
      });
    });
  }

  Future checkChangesCart(BuildContext context) async {
    await service.getUserCartRequest((response) {
      mapper.getUserCartResponse(response, (model) {
        if(model != null) {
          if(model.status == true) {
            userCart = model;
            notifyListeners();
          } else {
            userCart = null;
            notifyListeners();
          }
        }
      });
    });
  }

  GetProductsCategoryResponseModel? otherProductsModel;
  bool otherProductsLoading = false;

  Future otherProducts() async {
    otherProductsLoading = true;
    notifyListeners();
    await service.getProductsCategoryRequest(productsCategoryPageNumber, 1, null, (response) {
      mapper.getProductsCategoryResponse(response, (model) {
        otherProductsLoading = false;
        notifyListeners();
        if(model != null) {
          if(model.status == true) {
            productsCategoryModel = model;
            productsCategoryLastPageNumber = model.lastPage ?? 1;
            notifyListeners();
          }
        }
      });
    });
  }

    Future addingProductWidget({
    required BuildContext context,
    required int added,
    required Function() onCancel,
    required Function() onAgree,
  }) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        duration: const Duration(
          seconds: 2,
        ),
        padding: EdgeInsets.only(
          top: 3.4.h,
          left: 6.w,
          right: 6.w,
          bottom: 3.h,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ConstantsAssets.successfullyMarkImage,
              height: 8.6.h,
              width: 8.6.h,
            ),
            SizedBox(
              height: 3.5.h,
            ),
            Text(
              'Добавлено в корзину',
              style: TextStyle(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 19.5.sp,
                fontFamily: ConstantsFonts.latoSemiBold,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              'Всего $added предмет',
              style: TextStyle(
                color: const Color.fromRGBO(0, 0, 0, 0.5),
                fontSize: 9.5.sp,
                fontFamily: ConstantsFonts.latoSemiBold,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            MainButton(
              text: 'В КОРЗИНУ',
              onTap: () => onAgree(),
              activeColor: const Color.fromRGBO(87, 167, 109, 1),
              textStyle: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontFamily: ConstantsFonts.latoSemiBold,
                fontSize: 9.5.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

}