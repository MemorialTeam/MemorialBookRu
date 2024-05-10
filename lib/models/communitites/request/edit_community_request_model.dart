import 'dart:io';

class EditCommunityRequestModel {
  final String title;
  final String subtitle;
  final String description;
  final String email;
  final String phone;
  final String? website;
  final String address;
  final File? avatar;
  final File? banner;
  final List<dynamic>? gallery;
  final List<String>? mediaRemovedIds;

  EditCommunityRequestModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.avatar,
    required this.banner,
    required this.gallery,
    required this.mediaRemovedIds,
  });
}