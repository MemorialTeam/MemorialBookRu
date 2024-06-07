import '../../catalog/response/get_authorized_content_response_model.dart';
import 'get_community_info_response_model.dart';

class SearchCommunityInfoResponseModel {
  bool? status;
  List<CommunityDataResponseModel>? communities;


  SearchCommunityInfoResponseModel({
    required this.status,
    required this.communities,
  });

  SearchCommunityInfoResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['communities'] != null ?
    communities = List.of(json['communities']['data']).map((index) => CommunityDataResponseModel.fromJson(index)).toList() :
    null;
  }
}
