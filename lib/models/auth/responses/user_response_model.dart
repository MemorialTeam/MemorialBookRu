class UserResponseModel {
  int? id;
  String? username;
  String? email;
  String? avatar;
  String? createdAt;

  UserResponseModel({
    this.id,
    this.username,
    this.email,
    this.avatar,
    this.createdAt,
  });

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    id = data['id'];
    username = data['username'];
    email = data['email'];
    avatar = data['avatar'];
    createdAt = data['created_at'];

    return data;
  }
}