import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import '../../common/links_reponse_model.dart';
import 'created_pet_profile_response_model.dart';

class GettingCreatedPetsProfilesResponseModel {
  bool? status;
  CreatedPetsDataResponseModel? pets;

  GettingCreatedPetsProfilesResponseModel({
    required this.status,
    required this.pets,
  });

  GettingCreatedPetsProfilesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pets = CreatedPetsDataResponseModel.fromJson(json['pets']);
  }
}

class CreatedPetsDataResponseModel {
  List<CreatedPetProfileResponseModel>? data;
  LinksResponseModel? links;

  CreatedPetsDataResponseModel({
    required this.data,
    required this.links,
  });

  CreatedPetsDataResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      data = List.of(json['data']).map(
        ((index) => CreatedPetProfileResponseModel.fromJson(index)),
      ).toList();
      links = LinksResponseModel.fromJson(json['links']);
    } catch(error) {
      print('$error');
      SVProgressHUD.dismiss();
    }
  }
}