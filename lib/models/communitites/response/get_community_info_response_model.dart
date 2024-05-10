import 'package:flutter/cupertino.dart';
import 'package:memorial_book/helpers/constants.dart';

class GetCommunityInfoResponseModel {
  bool? status;
  CommunitiesInfoResponseModel? community;
  List<CommunitiesInfoResponseModel>? communities;
  List<CommunitiesInfoResponseModel>? featuredCommunities;

  GetCommunityInfoResponseModel({
    required this.status,
    required this.community,
    required this.communities,
    required this.featuredCommunities,
  });

  GetCommunityInfoResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['communities'] != null && json['communities'].runtimeType == [].runtimeType) {
      communities = List
          .from(json['communities'])
          .map(
            (index) => CommunitiesInfoResponseModel.fromJson(index),
      ).toList();
    } else {
      community = CommunitiesInfoResponseModel.fromJson(json['communities']);
    }
    json['featured_communities'] != null ?
    featuredCommunities = List
        .from(json['featured_communities'])
        .map(
          (index) => CommunitiesInfoResponseModel.fromJson(index),
    ).toList() :
    null;
  }
}

class CommunitiesInfoResponseModel {
  int? id;
  bool? isSubscribe;
  bool? isAdmin;
  String? title;
  String? subtitle;
  String? description;
  String? address;
  String? email;
  String? phone;
  String? website;
  Map<String, dynamic>? socialLinks;
  String? createdAt;
  String? banner;
  String? avatar;
  List? gallery;
  List? movies;
  int? subscribersCount;
  List<SubscribersInfoResponseModel>? lastSubscribers;

  CommunitiesInfoResponseModel({
    required this.id,
    required this.isSubscribe,
    required this.isAdmin,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.address,
    required this.email,
    required this.phone,
    required this.website,
    required this.socialLinks,
    required this.createdAt,
    required this.banner,
    required this.avatar,
    required this.gallery,
    required this.movies,
    required this.subscribersCount,
    required this.lastSubscribers,
  });

  CommunitiesInfoResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      isSubscribe = json['is_subscribe'];
      isAdmin = json['is_admin'];
      title = json['title'];
      subtitle = json['subtitle'];
      description = json['description'];
      if (json['address'] != null) {
        address = json['address'];
      }
      if (json['email'] != null) {
        email = json['email'];
      }
      if (json['phone'] != null) {
        phone = json['phone'];
      }
      if (json['website'] != null) {
        website = json['website'];
      }
      if (json['social_links'] != null) {
        socialLinks = json['social_links'];
      }
      createdAt = json['created_at'];
      banner = json['banner'];
      avatar = json['avatar'];
      json['gallery'] != null ?
      gallery = json['gallery'] :
      null;
      json['movies'] != null ?
      movies = json['movies'] :
      null;
      json['subscribers_count'] != null ?
      subscribersCount = json['subscribers_count'] :
      null;
      json['last_subscribers'] != null ?
      lastSubscribers = List.from(json['last_subscribers']).map(
            (index) => SubscribersInfoResponseModel.fromJson(index),
      ).toList() :
      null;
      json['movies'] != null ?
      movies = json['movies'] :
      null;
    } catch(e) {
      print('$e');
    }
  }
}

class PostsResponseModel {
  int? id;
  bool? isPinned;
  String? title;
  String? description;
  late PostContentType contentType;
  String? publishedAt;
  SubscribersInfoResponseModel? author;
  int? pageIndex;
  PageController? pageController;
  List? gallery;

  PostsResponseModel({
    required this.id,
    required this.isPinned,
    required this.title,
    required this.description,
    required this.contentType,
    required this.publishedAt,
    required this.author,
    required this.pageIndex,
    required this.pageController,
    required this.gallery,
  });

  PostsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isPinned = json['is_pinned'];
    title = json['title'];
    description = json['description'];
    publishedAt = json['published_at'];
    author = SubscribersInfoResponseModel.fromJson(json['author']);
    pageIndex = 0;
    pageController = PageController();
    if(json['gallery'] != null) {
      gallery = json['gallery'];
    } else {
      gallery = [];
    }
    if(title != null && description != null && gallery!.isEmpty) {
      contentType = PostContentType.textContent;
    } else if(title != null && description != null && gallery!.isNotEmpty) {
      contentType = PostContentType.textWithMediaContent;
    } else if(title == null && description == null && gallery!.isNotEmpty) {
      contentType = PostContentType.mediaContent;
    } else {
      contentType = PostContentType.none;
    }
  }
}

class ContentResponseModel {
  int? id;
  String? title;
  String? description;
  GalleryResponseModel? gallery;
  
  ContentResponseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.gallery,
  });
  
  ContentResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    gallery = GalleryResponseModel.fromJson(json['gallery']);
  }
}

class GalleryResponseModel {
  List? images;

  GalleryResponseModel({
    required this.images,
  });

  GalleryResponseModel.fromJson(Map<String, dynamic> json) {
    json['images'] != null ?
    images = json['images'] :
    null;
  }
}

class MediaResponseModel {
  List? images;
  List? videos;

  MediaResponseModel({
    required this.images,
    required this.videos,
  });

  MediaResponseModel.fromJson(Map<String, dynamic> json) {
    images = json['images'];
    videos = json['videos'];
  }
}

class SubscribersInfoResponseModel {
  int? id;
  String? username;
  String? email;
  String? avatar;
  String? role;
  String? createdAt;

  SubscribersInfoResponseModel({
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.role,
    required this.createdAt,
  });

  SubscribersInfoResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    role = json['role'];
    createdAt = json['created_at'];
  }
}

class MemorialsResponseModel {
  int? id;
  String? fullName;
  dynamic yearBirth;
  dynamic yearDeath;
  String? avatar;

  MemorialsResponseModel({
    required this.id,
    required this.fullName,
    required this.yearBirth,
    required this.yearDeath,
    required this.avatar,
  });

  MemorialsResponseModel.fromJson(Map<String, dynamic> json) {
    if(json['id'] != null) {
      id = json['id'];
    }
    fullName = json['full_name'];
    yearBirth = json['year_birth'];
    yearDeath = json['year_death'];
    avatar = json['avatar'];
  }
}