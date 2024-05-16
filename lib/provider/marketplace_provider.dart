import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/models/market/item_model.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:sizer/sizer.dart';
import '../data_handler/mapper.dart';
import '../data_handler/service.dart';
import '../models/market/response/get_shop_response_model.dart';
import '../models/market/response/products_response_models/get_product_by_id_reponse_model.dart';
import '../models/market/response/products_response_models/get_products_category_response_model.dart';
import '../models/market/response/products_response_models/product_data_response_model.dart';

class MarketplaceProvider extends ChangeNotifier {
  int currentPost = 0;

  final service = Service();
  final mapper = Mapper();

  void onPageChanged(int page, CarouselPageChangedReason controller) {
    currentPost = page;
    notifyListeners();
  }

  List<ItemModel> products = [
    ItemModel(
      id: 1,
      productName: 'Букет цветов',
      price: '29,99',
      description: 'Прекрасный букет цветов освежит память Вашего родственника',
      doneAt: '28.02.2021',
      avatar: 'https://static.tildacdn.com/stor6665-6566-4836-a465-633639633532/11155756.png',
      gallery: [
        'https://binomen.ru/photo/uploads/posts/2024-01/1706158470_binomen-ru-p-tsveti-rozi-buket-krasivo-50.jpg',
        'https://binomen.ru/photo/uploads/posts/2024-01/1706158470_binomen-ru-p-tsveti-rozi-buket-krasivo-50.jpg',
        'https://binomen.ru/photo/uploads/posts/2024-01/1706158470_binomen-ru-p-tsveti-rozi-buket-krasivo-50.jpg',
      ],
    ),
    ItemModel(
      id: 2,
      productName: 'QR-code',
      price: '29,99',
      description: 'Вы можете прикрепить своего родственника к QR коду',
      doneAt: '28.02.2021',
      avatar: 'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
      gallery: [
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
      ],
    ),
    ItemModel(
      id: 3,
      productName: 'Букет цветов',
      price: '29,99',
      description: 'Вы можете прикрепить своего родственника к QR коду',
      doneAt: '28.02.2021',
      avatar: 'https://www.funnyart.club/uploads/posts/2023-06/1686041422_funnyart-club-p-buket-tsvetov-na-belom-fone-krasota-27.jpg',
      gallery: [
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
      ],
    ),
  ];

  List<ItemModel> services = [
    ItemModel(
      id: 4,
      productName: 'Clean A Headstone',
      price: '29,99',
      description: 'Прекрасный букет цветов освежит память Вашего родственника',
      doneAt: '28.02.2021',
      avatar: 'https://avatars.mds.yandex.net/get-altay/2356223/2a00000171ecad95966c3c9091ef947c0f23/XXXL',
      gallery: [
        'https://binomen.ru/photo/uploads/posts/2024-01/1706158470_binomen-ru-p-tsveti-rozi-buket-krasivo-50.jpg',
        'https://binomen.ru/photo/uploads/posts/2024-01/1706158470_binomen-ru-p-tsveti-rozi-buket-krasivo-50.jpg',
        'https://binomen.ru/photo/uploads/posts/2024-01/1706158470_binomen-ru-p-tsveti-rozi-buket-krasivo-50.jpg',
      ],
    ),
    ItemModel(
      id: 5,
      productName: 'Installing QR-code',
      price: '29,99',
      description: 'Вы можете прикрепить своего родственника к QR коду',
      doneAt: '28.02.2021',
      avatar: 'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
      gallery: [
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
      ],
    ),
    ItemModel(
      id: 6,
      productName: 'Облагораживание',
      price: '29,99',
      description: 'Вы можете прикрепить своего родственника к QR коду',
      doneAt: '28.02.2021',
      avatar: 'https://ritual-uslugi31.ru/wp-content/uploads/2023/02/cropped-DSC_0083_09.jpg',
      gallery: [
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
        'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
      ],
    ),
  ];

  List<ProductDataResponseModel> basket = [];

  void addItem(ProductDataResponseModel item) {
    if(basket.contains(item) == false) {
      basket.add(item);
      notifyListeners();
    }
    item.numberOfAdded++;
    notifyListeners();
  }

  double grandTotal() {
    double price = 0;
    for(ProductDataResponseModel i in basket) {
      double convertPriceToDouble = double.parse(i.price!.toString().replaceAll(',', '.'));
      double convertedTotalPrice = convertPriceToDouble * i.numberOfAdded;
      price = price + convertedTotalPrice;
    }
    return price;
  }

  int totalAdded() {
    int total = 0;
    for(ProductDataResponseModel i in basket) {
      total = total + i.numberOfAdded;
    }
    return total;
  }

  Future removeItem(ProductDataResponseModel item, BuildContext context) async {
    if(item.numberOfAdded == 1) {
      await productDeletionWidget(
        context: context,
        onCancel: () => Navigator.pop(context),
        onAgree: () {
          item.numberOfAdded--;
          basket.remove(item);
          notifyListeners();
          Navigator.pop(context);
        },
      );
    } else {
      item.numberOfAdded--;
      notifyListeners();
    }
  }

  GetShopResponseModel? shopModel;

  GetProductsCategoryResponseModel? productsCategoryModel;
  bool productsCategoryLoading = false;
  bool productsCategoryPaginationLoading = false;
  int productsCategoryPageNumber = 1;
  int productsCategoryLastPageNumber = 1;

  Future getProductsCategory() async {
    productsCategoryPageNumber = 1;
    productsCategoryModel = null;
    productsCategoryLoading = true;
    notifyListeners();
    await service.getProductsCategoryRequest(productsCategoryPageNumber, 1, (response) {
      mapper.getProductsCategoryResponse(response, (model) {
        productsCategoryLoading = false;
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
    SVProgressHUD.show();
    await service.getProductsCategoryRequest(productsCategoryPageNumber, 1, (response) {
      mapper.getProductsCategoryResponse(response, (model) {
        SVProgressHUD.dismiss();
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

  GetProductsCategoryResponseModel? productsMainModel;
  bool productsMainLoading = false;
  bool productsMainPaginationLoading = false;
  int productsMainPageNumber = 1;
  int productsMainLastPageNumber = 1;

  Future getProductsMain() async {
    productsMainPageNumber = 1;
    productsMainModel = null;
    productsMainLoading = true;
    notifyListeners();
    await service.getProductsCategoryRequest(productsMainPageNumber, 1, (response) {
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
    await service.getProductsCategoryRequest(productsMainPageNumber, 1, (response) {
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
    await service.getServicesCategoryRequest(productsMainPageNumber, 1, (response) {
      mapper.getServicesCategoryResponse(response, (model) {
        servicesMainLoading = false;
        notifyListeners();
        print(response?.body);
        if(model != null) {
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
    await service.getProductsCategoryRequest(servicesMainPageNumber, 1, (response) {
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

  Future getShop(int cemeteryId, ValueSetter<GetShopResponseModel?> completion) async {
    await service.getShopRequest(cemeteryId, (response) {
      mapper.getShopResponse(response, (model) {
        if(model != null) {
          if(model.status == true) {
            shopModel = model;
            notifyListeners();
          }
          completion(model);
        } else {
          completion(null);
        }
      });
    });
  }

  Future productDeletionWidget({
    required BuildContext context,
    required Function() onCancel,
    required Function() onAgree,
  }) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 4.h,
            left: 6.w,
            right: 6.w,
            bottom: 3.5.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ConstantsAssets.questionMarkImage,
                height: 8.6.h,
                width: 8.6.h,
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                'Удалить товар из корзины',
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
                'вы удалите 1 позицию в корзине',
                style: TextStyle(
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  fontSize: 9.5.sp,
                  fontFamily: ConstantsFonts.latoSemiBold,
                ),
              ),
              SizedBox(
                height: 3.5.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: MainButton(
                      text: 'НЕТ Я ПЕРЕДУМАЛ',
                      onTap: () => onCancel(),
                      activeColor: const Color.fromRGBO(225, 228, 231, 1),
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        fontFamily: ConstantsFonts.latoSemiBold,
                        fontSize: 9.5.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(
                    child: MainButton(
                      text: 'ДА',
                      onTap: () => onAgree(),
                      activeColor: const Color.fromRGBO(255, 76, 94, 1),
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: ConstantsFonts.latoSemiBold,
                        fontSize: 9.5.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}