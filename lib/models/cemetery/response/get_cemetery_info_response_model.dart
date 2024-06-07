import '../../common/image_response_model.dart';
import '../../people/response/get_map_of_people_response_model.dart';

class GetCemeteryInfoResponseModel {
  bool? status;
  CemeteryResponseModel? cemetery;

  GetCemeteryInfoResponseModel({
    required this.status,
    required this.cemetery,
  });

  GetCemeteryInfoResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['cemetery'] != null) {
      cemetery = CemeteryResponseModel.fromJson(json['cemetery']);
    }
  }
}

class CemeteryResponseModel {
  dynamic id;
  bool? isSubscribe;
  String? name;
  String? description;
  String? address;
  CoordsResponseModel? addressCoords;
  String? avatar;
  String? banner;
  List<ImageResponseModel>? gallery;
  List<FamousPersonalitiesResponseModel>? memorials;
  List<FamousPersonalitiesResponseModel>? famousPersonalities;

  CemeteryResponseModel({
   this.id,
   this.isSubscribe,
   this.name,
   this.description,
   this.address,
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
      name = json['name'];
      if(json['description'] != null) {
        description = json['description'];
      }
      address = json['address'];
      avatar = json['avatar'];
      banner = json['banner'];
      json['address_coords'] != null ?
      addressCoords = CoordsResponseModel.fromJson(json['address_coords']) :
      null;
      gallery = List.of(json['gallery']).map(
        ((index) => ImageResponseModel.fromJson(index)),
      ).toList();
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
  bool? isCelebrity;
  String? firstName;
  String? lastName;
  String? middleName;
  dynamic yearBirth;
  dynamic yearDeath;
  dynamic dateBirth;
  dynamic dateDeath;
  String? avatar;
  String? createdAt;

  FamousPersonalitiesResponseModel({
    required this.id,
    required this.isCelebrity,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.yearBirth,
    required this.yearDeath,
    required this.dateBirth,
    required this.dateDeath,
    required this.avatar,
    required this.createdAt,
  });

  FamousPersonalitiesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isCelebrity = json['is_celebrity'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    yearBirth = json['year_birth'];
    yearDeath = json['year_death'];
    dateBirth = json['date_birth'];
    dateDeath = json['date_death'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
  }
}