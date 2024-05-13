import 'package:memorial_book/models/market/response/shop_requisite_response_model.dart';
import '../../people/response/get_map_of_people_response_model.dart';

class ShopResponseModel {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? address;
  CoordsResponseModel? shopAddressCoords;
  String? description;
  String? status;
  bool? hasPickup;
  String? createdAt;
  ShopRequisiteResponseModel? shopRequisite;

  ShopResponseModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.shopAddressCoords,
    required this.description,
    required this.status,
    required this.hasPickup,
    required this.createdAt,
    required this.shopRequisite,
  });

  ShopResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    shopAddressCoords = CoordsResponseModel.fromJson(json['shop_address_coords']);
    description = json['description'];
    status = json['status'];
    hasPickup = json['has_pickup'];
    createdAt = json['created_at'];
    shopRequisite = ShopRequisiteResponseModel.fromJson(json['shop_requisite']);
  }
}