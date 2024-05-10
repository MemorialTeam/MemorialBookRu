import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:memorial_book/models/people/response/created_human_profile_response_model.dart';

class GettingCreatedHumansProfilesResponseModel {
  bool? status;
  CreatedHumansDataResponseModel? humans;

  GettingCreatedHumansProfilesResponseModel({
    required this.status,
    required this.humans,
  });

  GettingCreatedHumansProfilesResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      status = json['status'];
      humans = CreatedHumansDataResponseModel.fromJson(json['humans']);
    } catch(error) {
      print('$error');
      SVProgressHUD.dismiss();
    }
  }
}

class CreatedHumansDataResponseModel {
  List<CreatedHumanProfileResponseModel>? data;
  int? lastPage;

  CreatedHumansDataResponseModel({
    required this.data,
    required this.lastPage,
  });

  CreatedHumansDataResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      data = List.of(json['data']).map(
        ((index) => CreatedHumanProfileResponseModel.fromJson(index)),
      ).toList();
      lastPage = json['meta']['last_page'];
    } catch(error) {
      print('$error');
      SVProgressHUD.dismiss();
    }
  }
}