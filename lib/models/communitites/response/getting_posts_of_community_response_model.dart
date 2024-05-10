import 'get_community_info_response_model.dart';

class GettingPostsOfCommunityResponseModel {
  bool? status;
  String? message;
  PostsDataResponseModel? posts;

  GettingPostsOfCommunityResponseModel({
    required this.status,
    required this.message,
    required this.posts,
  });

  GettingPostsOfCommunityResponseModel.fromJson(Map<String, dynamic> json) {
    if(json['message'] == null) {
      status = json['status'];
      posts = PostsDataResponseModel.fromJson(json['posts']);
    } else {
      message = json['message'];
    }
  }
}

class PostsDataResponseModel {
  List<PostsResponseModel>? data;
  int? total;

  PostsDataResponseModel({
    required this.data,
    required this.total,
  });

  PostsDataResponseModel.fromJson(Map<String, dynamic> json) {
    data = List.of(json['data']).map(
      ((index) => PostsResponseModel.fromJson(index)),
    ).toList();
    total = json['meta']['total'];
  }
}
