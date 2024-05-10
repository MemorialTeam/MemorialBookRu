class RelatedProfilesResponseModel {
  bool? status;
  List<HumansResponseModel>? humans;

  RelatedProfilesResponseModel({
    required this.status,
    required this.humans,
  });

  RelatedProfilesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['humans'] != null ?
    humans = List
        .of(json['humans'])
        .map(
          (index) => HumansResponseModel.fromJson(index),
    ).toList() :
    null;
  }
}

class HumansResponseModel {
  int? id;
  String? fullName;

  HumansResponseModel({
    required this.id,
    required this.fullName,
  });

  HumansResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
  }
}