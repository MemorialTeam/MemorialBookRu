class ImageResponseModel {
  int? id;
  String? url;
  String? thumb;

  ImageResponseModel({
    required this.id,
    required this.url,
    required this.thumb,
  });

  ImageResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    thumb = json['thumb'];
  }
}