class SearchCemeteryForHumanResponseModel {
  bool? status;
  int? total;
  List<CemeteryResponseModel>? cemeteries;

  SearchCemeteryForHumanResponseModel({
    required this.status,
    required this.total,
    required this.cemeteries,
  });

  SearchCemeteryForHumanResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['status'] == true) {
      total = json['total'];
      cemeteries = List.of(json['cemeteries']).map(
        ((index) => CemeteryResponseModel.fromJson(index)),
      ).toList();
    }
  }
}

class CemeteryResponseModel {
  int? id;
  String? name;
  String? address;

  CemeteryResponseModel({
    required this.id,
    required this.name,
    required this.address,
  });

  CemeteryResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }
}