class UserInfoResponseModel {
  bool? status;
  String? message;
  UserInformation? user;

  UserInfoResponseModel({
    this.status,
    this.message,
    this.user,
  });

  UserInfoResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['message'] != null ?
    message = json['message'] :
    null;
    json['user'] != null ?
    user = UserInformation.fromJson(json['user']) :
    null;
  }
}

class UserInformation {
  String? username;
  String? email;
  String? avatar;
  int? profilesCount;
  int? accessesCount;

  UserInformation({
    this.username,
    this.email,
    this.avatar,
    this.profilesCount,
    this.accessesCount,
  });

  UserInformation.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    profilesCount = json['profiles_count'];
    accessesCount = json['accesses_count'];
  }
}