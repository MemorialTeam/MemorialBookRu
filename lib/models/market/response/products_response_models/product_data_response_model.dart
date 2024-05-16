import 'package:memorial_book/models/market/response/category_response_model.dart';
import '../../../common/image_response_model.dart';
import '../../options_model/options_response_model.dart';

class ProductDataResponseModel {
  int? id;
  int? shopId;
  CategoryResponseModel? category;
  /// moderation_comment
  late int numberOfAdded;
  String? status;
  String? name;
  String? mainPhoto;
  String? slug;
  String? description;
  int? price;
  int? discount;
  int? discountedPrice;
  OptionsResponseModel? options;
  String? createdAt;
  List<ImageResponseResponseModel>? gallery;

  ProductDataResponseModel({
    required this.id,
    required this.shopId,
    required this.category,
    required this.numberOfAdded,
    required this.status,
    required this.name,
    required this.mainPhoto,
    required this.slug,
    required this.description,
    required this.price,
    required this.discount,
    required this.discountedPrice,
    required this.options,
    required this.createdAt,
    required this.gallery,
  });

  ProductDataResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    category = CategoryResponseModel.fromJson(json['category']);
    numberOfAdded = 0;
    if(json['status'] != null) {
      status = json['status'];
    }
    name = json['name'];
    if(json['main_photo'] != null) {
      mainPhoto = json['main_photo'];
    }
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    discountedPrice = json['discounted_price'];
    options = OptionsResponseModel.fromJson(json['options']);
    createdAt = json['created_at'];
    gallery = List.of(json['gallery']).map(
      ((index) => ImageResponseResponseModel.fromJson(index)),
    ).toList();
  }
}