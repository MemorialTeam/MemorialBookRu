import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class StatusResponseModel {
  bool? status;
  String? message;

  StatusResponseModel({
    required this.status,
    this.message,
  });

  StatusResponseModel.fromJson(Map<String, dynamic> json) {
    try{
      json['status'] != null ?
      status = json['status'] :
      null;
      json['message'] != null && json['message'].runtimeType == String ?
      message = json['message'] :
      null;
    } catch(error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    status = data['status'];
    // dataResponse = data['pet'] ?? {};
    // message = data['message'];

    return data;
  }
}