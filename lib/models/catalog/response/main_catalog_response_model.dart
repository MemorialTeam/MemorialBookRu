import 'data_of_catalog_response_model.dart';

class MainCatalogResponseModel {
  bool? status;
  DataOfCatalogResponseModel? dataOfCatalog;

  MainCatalogResponseModel({
    required this.status,
    required this.dataOfCatalog,
  });

  MainCatalogResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dataOfCatalog = json['data'] != null ?
    DataOfCatalogResponseModel.fromJson(json['data']) :
    null;
  }
}
