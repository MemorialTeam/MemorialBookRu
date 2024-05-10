import '../../../widgets/cards/horizontal_mini_card_widget.dart';
import '../../people/response/get_map_of_people_response_model.dart';

class GetAuthorizedContentResponseModel {
  bool? status;
  String? message;
  DataAuthorizedContentResponseModel? feed;

  GetAuthorizedContentResponseModel({
    required this.status,
    required this.message,
    required this.feed,
  });

  GetAuthorizedContentResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(message != null) {
      message = json['message'];
    } else {
      feed = DataAuthorizedContentResponseModel.fromJson(json['feed']);
    }
  }
}

class DataAuthorizedContentResponseModel {
  List<HumanDataResponseModel>? humans;
  List<CemeteryDataResponseModel>? cemeteries;
  List<CelebrityPetDataResponseModel>? pets;
  List<CommunityDataResponseModel>? communities;

  DataAuthorizedContentResponseModel({
    required this.humans,
    required this.cemeteries,
    required this.pets,
    required this.communities,
  });

  DataAuthorizedContentResponseModel.fromJson(Map<String, dynamic> json) {
    humans = List.of(json['humans']).map(
      ((index) => HumanDataResponseModel.fromJson(index)),
    ).toList();
    cemeteries = List.of(json['cemeteries']).map(
      ((index) => CemeteryDataResponseModel.fromJson(index)),
    ).toList();
    pets = List.of(json['pets']).map(
      ((index) => CelebrityPetDataResponseModel.fromJson(index)),
    ).toList();
    communities = List.of(json['communities']).map(
      ((index) => CommunityDataResponseModel.fromJson(index)),
    ).toList();
  }
}

class HumanDataResponseModel {
  int? id;
  bool? isCelebrity;
  StateOfMemorial? isAdded;
  String? firstName;
  String? lastName;
  String? middleName;
  String? dateBirth;
  String? dateDeath;
  String? yearBirth;
  String? yearDeath;
  String? avatar;
  BurialCordResponseModel? burialCord;
  String? createdAt;

  HumanDataResponseModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dateBirth,
    required this.dateDeath,
    required this.yearBirth,
    required this.yearDeath,
    required this.isCelebrity,
    required this.avatar,
    required this.burialCord,
    required this.createdAt,
  });

  HumanDataResponseModel.fromJson(Map<String, dynamic> json) {
    if(json['id'] != null) {
      id = json['id'];
    }
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    dateBirth = json['year_birth'];
    dateDeath = json['year_death'];
    if(json['date_birth'] != null) {
      dateBirth = json['date_birth'];
    }
    if(json['date_death'] != null) {
      dateDeath = json['date_death'];
    }
    if(json['year_birth'] != null) {
      yearBirth = json['year_birth'];
    }
    if(json['year_death'] != null) {
      yearDeath = json['year_death'];
    }
    if(json['is_celebrity'] != null) {
      isCelebrity = json['is_celebrity'];
    }
    avatar = json['avatar'];
    if(json['coords'] != null) {
      burialCord = BurialCordResponseModel.fromJson(json['coords']);
    }
    if(json['created_at'] != null) {
      createdAt = json['created_at'];
    }
    isAdded = StateOfMemorial.notAdded;
  }
}

class CemeteryDataResponseModel {
  int? id;
  String? title;
  String? subtitle;
  String? avatar;
  String? banner;

  CemeteryDataResponseModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.avatar,
    required this.banner,
  });

  CemeteryDataResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    avatar = json['avatar'];
    banner = json['banner'];
  }
}

class CelebrityPetDataResponseModel {
  int? id;
  String? name;
  String? dateBirth;
  String? dateDeath;
  String? yearBirth;
  String? yearDeath;
  bool? isCelebrity;
  String? avatar;

  CelebrityPetDataResponseModel({
    required this.id,
    required this.name,
    required this.dateBirth,
    required this.dateDeath,
    required this.yearBirth,
    required this.yearDeath,
    required this.isCelebrity,
    required this.avatar,
  });

  CelebrityPetDataResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateBirth = json['date_birth'];
    dateDeath = json['date_death'];
    yearBirth = json['year_birth'];
    yearDeath = json['year_death'];
    isCelebrity = json['is_celebrity'];
    avatar = json['avatar'];
  }
}

class CommunityDataResponseModel {
  int? id;
  bool? isOwner;
  String? title;
  String? subtitle;
  String? banner;
  String? avatar;
  String? createdAt;

  CommunityDataResponseModel({
    required this.id,
    required this.isOwner,
    required this.title,
    required this.subtitle,
    required this.banner,
    required this.avatar,
    required this.createdAt,
  });

  CommunityDataResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isOwner = json['is_owner'];
    title = json['title'];
    subtitle = json['subtitle'];
    avatar = json['avatar'];
    banner = json['banner'];
    createdAt = json['created_at'];
  }
}