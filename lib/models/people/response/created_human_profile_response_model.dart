
class CreatedHumanProfileResponseModel {
  int? id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? dateBirth;
  String? dateDeath;
  String? yearBirth;
  String? yearDeath;
  bool? isCelebrity;
  String? status;
  String? avatar;

  CreatedHumanProfileResponseModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dateBirth,
    required this.dateDeath,
    required this.yearBirth,
    required this.yearDeath,
    required this.isCelebrity,
    required this.status,
    required this.avatar,
  });

  CreatedHumanProfileResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    dateBirth = json['date_birth'];
    dateDeath = json['date_death'];
    yearBirth = json['year_birth'];
    yearDeath = json['year_death'];
    isCelebrity = json['is_celebrity'];
    status = json['status'];
    avatar = json['avatar'];
  }
}