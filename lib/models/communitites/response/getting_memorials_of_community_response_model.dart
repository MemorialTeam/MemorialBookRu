import 'package:memorial_book/models/common/links_reponse_model.dart';

import '../../../helpers/enums.dart';
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
  List<MemorialResponseModel>? data;
  LinksResponseModel? links;
  int? lastPage;

  MemorialsDataResponseModel({
    required this.data,
    required this.links,
    required this.lastPage,
  });

  MemorialsDataResponseModel.fromJson(Map<String, dynamic> json) {
    data = List.of(json['data']).map(
      ((index) => MemorialResponseModel.fromJson(index)),
    ).toList();
    links = LinksResponseModel.fromJson(json['links']);
    lastPage = json['meta']['to'];
  }
}

class MemorialResponseModel {
  int? id;
  late bool isLoading;
  String? fullName;
  ProfileType? profileType;
  dynamic dateBirth;
  dynamic dateDeath;
  String? avatar;

  MemorialResponseModel({
    required this.id,
    required this.isLoading,
    required this.fullName,
    required this.profileType,
    required this.dateBirth,
    required this.dateDeath,
    required this.avatar,
  });

  MemorialResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isLoading = false;
    fullName = json['full_name'];
    if(json['profile_type'] != null) {
      switch(json['profile_type']) {
        case 'human':
          profileType = ProfileType.human;
          break;
        case 'pet':
          profileType = ProfileType.pet;
          break;
        default:
          profileType = ProfileType.none;
          break;
      }
    }
    else {
      profileType = ProfileType.none;
    }
    dateBirth = json['date_birth'];
    dateDeath = json['date_death'];
    avatar = json['avatar'];
  }
}