import '../../people/response/get_map_of_people_response_model.dart';

class GetCemeteryInfoResponseModel {
  bool? status;
  CemeteryResponseModel? cemetery;
  List<CemeteryResponseModel>? cemeteryList;

  GetCemeteryInfoResponseModel({
    required this.status,
    required this.cemetery,
  });

  GetCemeteryInfoResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['cemetery'] != null) {
      cemetery = CemeteryResponseModel.fromJson(json['cemetery']);
    }
    else {
      json['cemeteries'] != null ?
      cemeteryList = List.of(json['cemeteries']).map(
        ((index) => CemeteryResponseModel.fromJson(index)),
      ).toList() :
      null;
    }
  }
}

class CemeteryResponseModel {
  dynamic id;
  bool? isSubscribe;
  String? title;
  String? subtitle;
  String? description;
  String? avatar;
  String? banner;
  CoordsResponseModel? addressCoords;
  List? gallery;
  List<FamousPersonalitiesResponseModel>? memorials;
  List<FamousPersonalitiesResponseModel>? famousPersonalities;

  CemeteryResponseModel({
   this.id,
   this.title,
   this.subtitle,
   this.description,
   this.avatar,
   this.banner,
   this.addressCoords,
   this.gallery,
   this.memorials,
   this.famousPersonalities,
  });

  CemeteryResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      isSubscribe = json['is_subscribe'];
      title = json['title'];
      subtitle = json['subtitle'];
      description = json['description'];
      avatar = json['avatar'];
      banner = json['banner'];
      json['address_coords'] != null ?
      addressCoords = CoordsResponseModel.fromJson(json['address_coords']) :
      null;
      gallery = json['gallery'];
      memorials = List.of(json['memorials']).map(
            (index) => FamousPersonalitiesResponseModel.fromJson(index),
      ).toList();
      famousPersonalities = List.of(json['famous_personalities']).map(
            (index) => FamousPersonalitiesResponseModel.fromJson(index),
      ).toList();
    } catch(error) {
      print('$error');
    }
  }
}

class FamousPersonalitiesResponseModel {
  int? id;
  String? fullName;
  dynamic dateBirth;
  dynamic dateDeath;
  CoordsResponseModel? burialCord;
  bool? isCelebrity;
  String? avatar;

  FamousPersonalitiesResponseModel({
    required this.id,
    required this.fullName,
    required this.dateBirth,
    required this.dateDeath,
    required this.burialCord,
    required this.isCelebrity,
    required this.avatar,
  });

  FamousPersonalitiesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    dateBirth = json['date_birth'];
    dateDeath = json['date_death'];
    json['burial_cord'] != null ?
    burialCord = CoordsResponseModel.fromJson(json['burial_cord']) :
    null;
    isCelebrity = json['is_celebrity'];
    avatar = json['avatar'];
  }
}