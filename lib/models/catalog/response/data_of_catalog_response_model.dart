class DataOfCatalogResponseModel {
  List? relatedHumans;
  List? celebrityHumans;
  List? cemeteries;
  List? celebrityPets;
  List? communities;
  List? news;

  DataOfCatalogResponseModel({
    required this.relatedHumans,
    required this.cemeteries,
    required this.celebrityPets,
    required this.communities,
    required this.news,
  });

  DataOfCatalogResponseModel.fromJson(Map<String, dynamic> json) {
    json['related_humans'] != null ?
    relatedHumans = json['related_humans']  :
    null;
    json['celebrity_humans'] != null ?
    celebrityHumans = json['celebrity_humans'] :
    null;
    cemeteries = json['cemeteries'];
    celebrityPets = json['celebrity_pets'];
    communities = json['communities'];
    news = json['news'];
  }
}
