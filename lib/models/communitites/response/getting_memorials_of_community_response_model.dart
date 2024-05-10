import '../../catalog/response/get_authorized_content_response_model.dart';
import 'get_community_info_response_model.dart';

class GettingMemorialsOfCommunityResponseModel {
  bool? status;
  String? message;
  MemorialsDataResponseModel? posts;

  GettingMemorialsOfCommunityResponseModel({
    required this.status,
    required this.message,
    required this.posts,
  });

  GettingMemorialsOfCommunityResponseModel.fromJson(Map<String, dynamic> json) {
    if(json['message'] == null) {
      status = json['status'];
      posts = MemorialsDataResponseModel.fromJson(json['memorials']);
    } else {
      message = json['message'];
    }
  }
}

class MemorialsDataResponseModel {
  List<HumanDataResponseModel>? data;
  int? lastPage;

  MemorialsDataResponseModel({
    required this.data,
    required this.lastPage,
  });

  MemorialsDataResponseModel.fromJson(Map<String, dynamic> json) {
    data = List.of(json['data']).map(
      ((index) => HumanDataResponseModel.fromJson(index)),
    ).toList();
    lastPage = json['meta']['last_page'];
  }
}