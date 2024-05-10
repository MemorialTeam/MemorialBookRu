class GetPeopleInfoResponseModel {
  bool? status;
  PeopleInfoResponseModel? human;
  List<KinsfolkInfoResponseModel>? kinsfolk;

  GetPeopleInfoResponseModel({
    required this.status,
    required this.human,
    required this.kinsfolk,
  });

  GetPeopleInfoResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    human = PeopleInfoResponseModel.fromJson(json['human']);
    json['kinsfolk'] != null ?
    kinsfolk = List.from(json['kinsfolk']).map(
          (index) => KinsfolkInfoResponseModel.fromJson(index),
    ).toList() :
    null;
  }
}

class PeopleInfoResponseModel {
  int? id;
  int? userId;
  bool? isCelebrity;
  String? firstName;
  String? lastName;
  String? middleName;
  String? gender;
  String? avatar;
  String? banner;
  dynamic dateBirth;
  dynamic dateDeath;
  String? deathReason;
  String? burialPlace;
  String? description;
  List? hobbies;
  String? religion;
  String? access;
  String? status;
  List? gallery;
  String? createdAt;

  PeopleInfoResponseModel({
    required this.id,
    required this.userId,
    required this.isCelebrity,
    required this.avatar,
    required this.banner,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.gender,
    required this.dateBirth,
    required this.dateDeath,
    required this.deathReason,
    required this.burialPlace,
    required this.description,
    required this.hobbies,
    required this.religion,
    required this.access,
    required this.status,
    required this.gallery,
    required this.createdAt,
  });

  PeopleInfoResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    isCelebrity = json['is_celebrity'];
    avatar = json['avatar'];
    banner = json['banner'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    gender = json['gender'];
    dateBirth = json['date_birth'];
    dateDeath = json['date_death'];
    burialPlace = json['burial_place'];
    deathReason = json['death_reason'];
    description = json['description'];
    hobbies = json['hobbies'];
    religion = json['religion'];
    access = json['access'];
    status = json['status'];
    gallery = json['gallery'];
    createdAt = json['created_at'];
  }

}

class KinsfolkInfoResponseModel {
  int? id;
  String? avatar;
  String? fullName;
  dynamic dateBirth;
  dynamic dateDeath;

  KinsfolkInfoResponseModel({
    required this.id,
    required this.avatar,
    required this.fullName,
    required this.dateBirth,
    required this.dateDeath,
  });

  KinsfolkInfoResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    fullName = json['full_name'];
    dateBirth = json['date_birth'];
    dateDeath = json['date_death'];
  }

}

class PetsInfoResponseModel {
  int? id;
  String? avatar;
  String? fullName;
  dynamic dateBirth;
  dynamic dateDeath;

  PetsInfoResponseModel({
    required this.id,
    required this.avatar,
    required this.fullName,
    required this.dateBirth,
    required this.dateDeath,
  });

  PetsInfoResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    fullName = json['name'];
    dateBirth = json['year_birth'];
    dateDeath = json['year_death'];
  }

}