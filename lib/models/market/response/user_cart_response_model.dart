import 'package:memorial_book/models/market/response/item_cart_response_model.dart';

class UserCartResponseModel {
  bool? status;
  int? id;
  int? total;
  int? count;
  List<ItemCartResponseModel>? items;

  UserCartResponseModel({
    required this.status,
    required this.id,
    required this.total,
    required this.count,
    required this.items,
  });

  UserCartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['status'] == true) {
      id = json['cart']['id'];
      total = json['cart']['total'];
      count = json['cart']['count'];
      items = List.of(json['cart']['items']).map(
        ((index) => ItemCartResponseModel.fromJson(index)),
      ).toList();
    } else {

    }
  }
}