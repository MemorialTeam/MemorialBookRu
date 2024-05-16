class ImageResponseResponseModel {
  int? id;
  String? url;
  String? thumb;

  ImageResponseResponseModel({
    required this.id,
    required this.url,
    required this.thumb,
  });

  ImageResponseResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    thumb = json['thumb'];
  }
}