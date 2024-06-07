import '../../people/response/get_map_of_people_response_model.dart';
import 'get_cemetery_info_response_model.dart';

class GettingTheUsersCemeteriesResponseModel {
  bool? status;
  List<CemeteriesResponseModel>? cemeteries;
  List<SearchCemeteriesResponseModel>? featuredCemeteries;

  GettingTheUsersCemeteriesResponseModel({
    required this.status,
    required this.cemeteries,
  });

  GettingTheUsersCemeteriesResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      status = json['status'];
      json['cemeteries'] != null ?
      cemeteries = List.of(json['cemeteries'])
          .map(
            (index) => CemeteriesResponseModel.fromJson(index),
      ).toList() :
      null;
      json['featured_cemeteries'] != null ?
      featuredCemeteries = List.of(json['featured_cemeteries'])
          .map(
            (index) => SearchCemeteriesResponseModel.fromJson(index),
      ).toList() :
      null;
    } catch(error) {
      print('$error');
    }

  }
}

class CemeteriesResponseModel {
  int? id;
  String? title;
  String? subtitle;
  String? avatar;
  String? banner;
  CoordsResponseModel? addressCoords;

  CemeteriesResponseModel({
    this.id,
    this.title,
    this.subtitle,
    this.avatar,
    this.banner,
    this.addressCoords,
  });

  CemeteriesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    avatar = json['avatar'];
    banner = json['banner'];
    addressCoords = CoordsResponseModel.fromJson(json['address_coords']);
  }
}

class SearchCemeteriesResponseModel {
  int? id;
  String? name;
  String? address;
  CoordsResponseModel? coords;
  String? avatar;
  String? banner;

  SearchCemeteriesResponseModel({
    this.id,
    this.name,
    this.address,
    this.coords,
    this.avatar,
    this.banner,
  });

  SearchCemeteriesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    coords = CoordsResponseModel.fromJson(json['address_coords']);
    avatar = json['avatar'];
    banner = json['banner'];
  }
}
