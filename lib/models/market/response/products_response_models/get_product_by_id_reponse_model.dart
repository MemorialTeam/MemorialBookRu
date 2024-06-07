import 'package:memorial_book/models/market/response/products_response_models/product_data_response_model.dart';

class GetProductByIdResponseModel {
  bool? status;
  ProductDataResponseModel? product;

  GetProductByIdResponseModel({
    required this.status,
    required this.product,
  });

  GetProductByIdResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['status'] == true) {
      if(json['product'] != null) {
        product = ProductDataResponseModel.fromJson(json['product']);
      } else {
        product = ProductDataResponseModel.fromJson(json['service']);
      }
    }
  }
}