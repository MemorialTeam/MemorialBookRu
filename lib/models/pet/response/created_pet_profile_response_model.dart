import 'package:memorial_book/helpers/enums.dart';

class CreatedPetProfileResponseModel {
  int? id;
  String? name;
  String? yearBirth;
  String? yearDeath;
  ProfileStatus? status;
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
    if(json['status'] != null) {
      switch(json['status']) {
        case 'active':
          status = ProfileStatus.active;
          break;
        case 'draft':
          status = ProfileStatus.draft;
          break;
        case 'private':
          status = ProfileStatus.private;
          break;
        default:
          status = ProfileStatus.none;
          break;
      }
    }
    isCelebrity = json['is_celebrity'];
    avatar = json['avatar'];
  }
}