import 'get_authorized_content_response_model.dart';

class GetGuestContentResponseModel {
  bool? status;
  String? message;
  DataGuestContentResponseModel? data;

  GetGuestContentResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  GetGuestContentResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(message != null) {
      message = json['message'];
    } else {
      data = DataGuestContentResponseModel.fromJson(json['data']);
    }
  }
}

class DataGuestContentResponseModel {
  List<HumanDataResponseModel>? celebrityHumans;
  List<CelebrityPetDataResponseModel>? celebrityPets;
  List<CemeteryDataResponseModel>? cemeteries;
  List<CommunityDataResponseModel>? communities;

  DataGuestContentResponseModel({
    required this.celebrityHumans,
    required this.celebrityPets,
    required this.cemeteries,
    required this.communities,
  });

  DataGuestContentResponseModel.fromJson(Map<String, dynamic> json) {
    celebrityHumans = List.of(json['celebrity_humans']).map(
      ((index) => HumanDataResponseModel.fromJson(index)),
    ).toList();
    celebrityPets = List.of(json['celebrity_pets']).map(
      ((index) => CelebrityPetDataResponseModel.fromJson(index)),
    ).toList();
    cemeteries = List.of(json['cemeteries']).map(
      ((index) => CemeteryDataResponseModel.fromJson(index)),
    ).toList();
    communities = List.of(json['communities']).map(
      ((index) => CommunityDataResponseModel.fromJson(index)),
    ).toList();
  }
}