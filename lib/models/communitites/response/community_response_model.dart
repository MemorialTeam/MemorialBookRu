import 'get_community_info_response_model.dart';

class CommunityResponseModel {
  bool? status;
  CommunitiesInfoResponseModel? communities;

  CommunityResponseModel({
    required this.status,
    required this.communities,
  });

  CommunityResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      status = json['status'];
      communities = CommunitiesInfoResponseModel.fromJson(json['communities']);
    } catch (error) {
      print('$error');
    }
  }
}