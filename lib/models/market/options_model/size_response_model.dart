class SizeResponseModel {
  String? unit;
  String? width;
  String? height;

  SizeResponseModel({
    required this.unit,
    required this.width,
    required this.height,
  });

  SizeResponseModel.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    width = json['width'];
    height = json['height'];
  }
}