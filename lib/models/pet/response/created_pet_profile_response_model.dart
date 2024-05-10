class CreatedPetProfileResponseModel {
  int? id;
  String? name;
  String? yearBirth;
  String? yearDeath;
  String? status;
  bool? isCelebrity;
  String? avatar;

  CreatedPetProfileResponseModel({
    required this.id,
    required this.name,
    required this.yearBirth,
    required this.yearDeath,
    required this.status,
    required this.isCelebrity,
    required this.avatar,
  });

  CreatedPetProfileResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    yearBirth = json['year_birth'];
    yearDeath = json['year_death'];
    status = json['status'];
    isCelebrity = json['is_celebrity'];
    avatar = json['avatar'];
  }
}