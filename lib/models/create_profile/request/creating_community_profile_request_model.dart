import 'dart:io';

class CreatingCommunityProfileRequestModel {
  final String title;
  final String subtitle;
  final String description;
  final String email;
  final String phone;
  final String? website;
  final List<String> socialLinks;
  final String address;
  final File? avatar;
  final File? banner;
  final List<File>? gallery;

  CreatingCommunityProfileRequestModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.email,
    required this.phone,
    required this.website,
    required this.socialLinks,
    required this.address,
    required this.avatar,
    required this.banner,
    required this.gallery,
  });
}
