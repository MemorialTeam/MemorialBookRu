import 'package:memorial_book/models/auth/responses/user_response_model.dart';

class SignUpResponseModel {
  bool? status;
  String? token;
  String? message;
  UserResponseModel? user;

  SignUpResponseModel({
    required this.status,
    required this.token,
    required this.message,
    required this.user,
  });

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    message = json['message'];
    user = json['user'] != null ? UserResponseModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    status = data['status'];
    token = data['token'];
    message = data['message'];
    if (user != null) {
      data['user'] = user?.toJson();
    }

    return data;
  }
}
