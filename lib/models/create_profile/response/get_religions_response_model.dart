class GetReligionsResponseModel {
  bool? status;
  String? message;
  List<ReligionResponseModel>? religions;
  
  GetReligionsResponseModel({
    required this.status,
    required this.message,
  });

  GetReligionsResponseModel.fromJson(Map<String, dynamic> json) {
    if(json['message'] == null) {
      status = json['status'];
      religions = List.of(json['religions']).map(
        ((index) => ReligionResponseModel.fromJson(index)),
      ).toList();
    } else {
      message = json['message'];
    }
  }
}

class ReligionResponseModel {
  int? id;
  String? title;

  ReligionResponseModel({
    required this.id,
    required this.title,
  });

  ReligionResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}