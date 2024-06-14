class GetDistrictsCemeteryResponseModel {
  bool? status;
  List<DistrictResponseModel>? districts;

  GetDistrictsCemeteryResponseModel({
    required this.status,
    required this.districts,
  });

  GetDistrictsCemeteryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['status'] == true) {
      districts = List.from(json['districts']).map(
        ((index) => DistrictResponseModel.fromJson(index)),
      ).toList();
    }
  }
}

class DistrictResponseModel {
  String? title;
  String? region;

  DistrictResponseModel({
    required this.title,
    required this.region,
  });

  DistrictResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    region = json['region'];
  }
}