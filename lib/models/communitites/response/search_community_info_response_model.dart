import 'get_community_info_response_model.dart';

class SearchCommunityInfoResponseModel {
  bool? status;
  List<CommunitiesInfoResponseModel>? communities;


  SearchCommunityInfoResponseModel({
    required this.status,
    required this.communities,
  });

  SearchCommunityInfoResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['communities'] != null ?
    communities = List.of(json['communities']['data']).map((index) => CommunitiesInfoResponseModel.fromJson(index)).toList() :
    null;
  }
}
