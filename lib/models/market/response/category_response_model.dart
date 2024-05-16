class CategoryResponseModel {
  int? id;
  String? name;
  String? slug;

  CategoryResponseModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }
}