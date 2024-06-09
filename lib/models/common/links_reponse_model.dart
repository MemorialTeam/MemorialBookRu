class LinksResponseModel {
  String? previousPageUrl;
  String? nextPageUrl;
  String? firstPageUrl;
  String? lastPageUrl;

  LinksResponseModel({
    required this.previousPageUrl,
    required this.nextPageUrl,
    required this.firstPageUrl,
    required this.lastPageUrl,
  });

  LinksResponseModel.fromJson(Map<String, dynamic> json) {
    previousPageUrl = json['previous_page_url'];
    nextPageUrl = json['next_page_url'];
    firstPageUrl = json['first_page_url'];
    lastPageUrl = json['last_page_url'];
  }
}