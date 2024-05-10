import 'package:memorial_book/models/cemetery/response/getting_the_users_cemeteries_response_model.dart';

class SearchCemeteryInfoResponseModel {
  bool? status;
  int? total;
  List<CemeteriesResponseModel>? cemeteryList;

  SearchCemeteryInfoResponseModel({
    required this.status,
    required this.total,
    required this.cemeteryList,
  });

  SearchCemeteryInfoResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    total = json['total'];
    json['cemeteries'] != null ?
    cemeteryList = List.of(json['cemeteries'])
        .map(
          (index) => CemeteriesResponseModel.fromJson(index),
    ).toList() :
    null;
  }
}