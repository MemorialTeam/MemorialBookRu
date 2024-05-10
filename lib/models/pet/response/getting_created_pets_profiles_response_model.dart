import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
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
  int? lastPage;

  CreatedPetsDataResponseModel({
    required this.data,
    required this.lastPage,
  });

  CreatedPetsDataResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      data = List.of(json['data']).map(
        ((index) => CreatedPetProfileResponseModel.fromJson(index)),
      ).toList();
      lastPage = json['meta']['last_page'];
    } catch(error) {
      print('$error');
      SVProgressHUD.dismiss();
    }
  }
}