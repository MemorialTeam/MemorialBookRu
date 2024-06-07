import '../../../helpers/enums.dart';

class ItemCartResponseModel {
  int? id;
  MarketplaceProductType? type;
  int? productId;
  String? name;
  int? price;
  int? totalDiscountPrice;
  int? quantity;
  String? avatar;

  ItemCartResponseModel({
    required this.id,
    required this.type,
    required this.productId,
    required this.name,
    required this.price,
    required this.totalDiscountPrice,
    required this.quantity,
    required this.avatar,
  });

  ItemCartResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['type'] != null) {
      switch(json['type']) {
        case 'product':
          type = MarketplaceProductType.products;
          break;
        case 'service':
          type = MarketplaceProductType.services;
          break;
        default:
          type = MarketplaceProductType.none;
          break;
      }
    } else {
      type = MarketplaceProductType.none;
    }
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    totalDiscountPrice = json['total_discount_price'];
    quantity = json['quantity'];
    avatar = json['avatar'];
  }
}