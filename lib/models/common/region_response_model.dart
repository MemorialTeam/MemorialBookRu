class RegionResponseModel {
  String? title;

  RegionResponseModel({
    required this.title,
  });

  RegionResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }
}