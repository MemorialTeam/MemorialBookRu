import 'package:memorial_book/models/market/options_model/size_response_model.dart';
import 'manufacturing_time_response_model.dart';

class OptionsResponseModel {
  SizeResponseModel? size;
  String? color;
  ManufacturingTimeResponseModel? manufacturingTime;

  OptionsResponseModel({
    required this.size,
    required this.color,
    required this.manufacturingTime,
  });

  OptionsResponseModel.fromJson(Map<String, dynamic> json) {
    if(json['size'] != null) {
      size = SizeResponseModel.fromJson(json['size']);
    }
    if(json['color'] != null) {
      color = json['color'];
    }
    if(json['manufacturing_time'] != null) {
      manufacturingTime = ManufacturingTimeResponseModel.fromJson(json['manufacturing_time']);
    }
  }
}