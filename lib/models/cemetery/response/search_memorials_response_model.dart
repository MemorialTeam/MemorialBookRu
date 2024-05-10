import '../../communitites/response/get_community_info_response_model.dart';

class SearchMemorialsResponseModel {
  bool? status;
  List<MemorialsResponseModel>? memorialsList;
  String? message;

  SearchMemorialsResponseModel({
    required this.status,
    required this.memorialsList,
    required this.message,
  });

  SearchMemorialsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['community_memorials'] != null) {
      memorialsList = List
          .of(json['community_memorials'])
          .map(
              (index) => MemorialsResponseModel.fromJson(index))
          .toList();
    }
    if(json['message'] != null) {
      message = json['message'];
    }
  }
}