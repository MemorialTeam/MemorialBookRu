import '../../common/region_response_model.dart';

class SearchRegionsCemeteryResponseModel {
  bool? status;
  List<RegionResponseModel>? regions;

  SearchRegionsCemeteryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    regions = List.from(json['regions']).map(
      ((index) => RegionResponseModel.fromJson(index)),
    ).toList();
  }
}