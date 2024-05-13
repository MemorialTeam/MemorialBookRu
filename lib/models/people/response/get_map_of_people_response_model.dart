import 'package:memorial_book/models/catalog/response/get_authorized_content_response_model.dart';

class GetMapOfPeopleResponseModel {
  bool? status;
  int? total;
  List<HumanDataResponseModel>? humans;

  GetMapOfPeopleResponseModel({
    required this.status,
    required this.humans,
  });

  GetMapOfPeopleResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    total = json['total'];
    json['humans'] != null ?
    humans = List.from(json['humans']).map(
          (index) => HumanDataResponseModel.fromJson(index),
    ).toList() :
    null;
  }
}

class CoordsResponseModel {
  dynamic lat;
  dynamic lng;

  CoordsResponseModel({
    required this.lat,
    required this.lng,
  });

  CoordsResponseModel.fromJson(Map<String, dynamic> json) {
    json['lat'] != null ?
    lat = json['lat'] :
    null;
    json['lng'] != null ?
    lng = json['lng'] :
    null;
  }
}