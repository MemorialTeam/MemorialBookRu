class GetHobbiesResponseModel {
  bool? status;
  List<HobbiesResponseModel>? hobbies;

  GetHobbiesResponseModel({
    required this.status,
    required this.hobbies,
  });

  GetHobbiesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    hobbies = List.of(json['hobbies']).map(
      ((index) => HobbiesResponseModel.fromJson(index)),
    ).toList();
  }
}

class HobbiesResponseModel {
  int? id;
  String? slug;
  String? title;

  HobbiesResponseModel({
    required this.id,
    required this.slug,
    required this.title,
  });

  HobbiesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
  }
}