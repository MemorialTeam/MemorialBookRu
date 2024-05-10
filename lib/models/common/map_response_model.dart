class MapResponseModel {
  String? status;
  List<CountryResponseModel>? predictions;

  MapResponseModel({
    required this.status,
    required this.predictions,
  });

  MapResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['predictions'] != null ?
    predictions = List.of(json['predictions'])
        .map(
          (index) => CountryResponseModel.fromJson(index),
    ).toList() :
    null;
  }
}

class CountryResponseModel {
  String? place;
  String? placeID;

  CountryResponseModel({
    required this.place,
    required this.placeID,
  });

  CountryResponseModel.fromJson(Map<String, dynamic> json) {
    place = json['description'];
    placeID = json['place_id'];
  }
}