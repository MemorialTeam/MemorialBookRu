import 'package:memorial_book/models/market/response/products_response_models/product_data_response_model.dart';

class GetProductsCategoryResponseModel {
  bool? status;
  String? message;
  List<ProductDataResponseModel>? productsData;
  int? lastPage;

  GetProductsCategoryResponseModel({
    required this.status,
    required this.message,
    required this.productsData,
    required this.lastPage,
  });

  GetProductsCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    if(json['status'] != null) {
      status = json['status'];
    }
    if(json['message'] != null) {
      message = json['message'];
    }
    if(json['status'] == true) {
      if(json['products'] != null) {
        productsData = List.of(json['products']['data']).map(
          ((index) => ProductDataResponseModel.fromJson(index)),
        ).toList();
        lastPage = json['products']['meta']['to'];
      }
      if(json['services'] != null) {
        productsData = List.of(json['services']['data']).map(
          ((index) => ProductDataResponseModel.fromJson(index)),
        ).toList();
        lastPage = json['services']['meta']['to'];
      }
    }
  }
}