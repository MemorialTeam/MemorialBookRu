import 'package:memorial_book/models/market/response/shop_response_model.dart';

class GetShopResponseModel {
  bool? status;
  String? message;
  ShopResponseModel? shop;

  GetShopResponseModel({
    required this.status,
    required this.message,
    required this.shop,
  });

  GetShopResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['status'] == true) {
      shop = ShopResponseModel.fromJson(json['shop']);
    } else {
      message = json['message'];
    }
  }
}