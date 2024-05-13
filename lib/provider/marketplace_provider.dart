import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:memorial_book/models/market/item_model.dart';
import '../data_handler/mapper.dart';
import '../data_handler/service.dart';
import '../models/market/response/get_shop_response_model.dart';

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

  List<ItemModel> basket = [];

  void addItem(ItemModel item) {
    if(basket.contains(item) == false) {
      basket.add(item);
      notifyListeners();
    }
    item.numberOfAdded++;
    notifyListeners();
  }

  double grandTotal() {
    double price = 0;
    for(ItemModel i in basket) {
      double convertPriceToDouble = double.parse(i.price.replaceAll(',', '.'));
      double convertedTotalPrice = convertPriceToDouble * i.numberOfAdded;
      price = price + convertedTotalPrice;
    }
    return price;
  }

  int totalAdded() {
    int total = 0;
    for(ItemModel i in basket) {
      total = total + i.numberOfAdded;
    }
    return total;
  }

  void removeItem(ItemModel item) {
    if(item.numberOfAdded == 1) {
      item.numberOfAdded--;
      basket.remove(item);
      notifyListeners();
    } else {
      item.numberOfAdded--;
      notifyListeners();
    }
  }

  GetShopResponseModel? shopModel;

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

  Future getProductsOnMain(int cemeteryId, ValueSetter<GetShopResponseModel?> completion) async {
    await service.getProductsOnMainRequest(cemeteryId, (response) {
      mapper.getProductsOnMainResponse(response, (model) {
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
}