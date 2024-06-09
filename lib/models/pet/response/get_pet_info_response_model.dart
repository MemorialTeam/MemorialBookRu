import 'package:memorial_book/models/common/image_response_model.dart';

class GetPetInfoResponseModel {
  bool? status;
  PetInfoResponseModel? pet;

  GetPetInfoResponseModel({
    required this.status,
    required this.pet,
  });

  GetPetInfoResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pet = PetInfoResponseModel.fromJson(json['pet']);
  }
}

class PetInfoResponseModel {
  int? id;
  int? userId;
  bool? isCelebrity;
  String? name;
  String? breed;
  String? deathReason;
  String? description;
  dynamic dateBirth;
  dynamic dateDeath;
  dynamic yearBirth;
  dynamic yearDeath;
  String? avatar;
  String? banner;
  List<ImageResponseModel>? gallery;
  String? createdAt;

  PetInfoResponseModel({
    required this.id,
    required this.userId,
    required this.isCelebrity,
    required this.name,
    required this.breed,
    required this.deathReason,
    required this.description,
    required this.dateBirth,
    required this.dateDeath,
    required this.yearBirth,
    required this.yearDeath,
    required this.avatar,
    required this.banner,
    required this.gallery,
    required this.createdAt,
  });

  PetInfoResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    isCelebrity = json['is_celebrity'];
    name = json['name'];
    breed = json['breed'];
    deathReason = json['death_reason'];
    description = json['description'];
    dateBirth = json['date_birth'];
    dateDeath = json['date_death'];
    yearBirth = json['year_birth'];
    yearDeath = json['year_death'];
    avatar = json['avatar'];
    banner = json['banner'];
    gallery = List.of(json['gallery']).map(
      ((index) => ImageResponseModel.fromJson(index)),
    ).toList();
    createdAt = json['created_at'];
  }
}

class OwnerInfoResponseModel {
  int? id;
  String? avatar;
  String? fullName;
  dynamic dateBirth;
  dynamic dateDeath;

  OwnerInfoResponseModel({
    required this.id,
    required this.avatar,
    required this.fullName,
    required this.dateBirth,
    required this.dateDeath,
  });

  OwnerInfoResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    fullName = json['full_name'];
    dateBirth = json['date_birth'];
    dateDeath = json['date_death'];
  }

}