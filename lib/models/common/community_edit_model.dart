class CommunityEditModel {
  final int id;
  final String title;
  final String subtitle;
  final String description;
  final String email;
  final String phone;
  final String? website;
  final List<String>? socialLinks;
  final String address;
  final String? avatar;
  final String? banner;

  CommunityEditModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.email,
    required this.phone,
    required this.website,
    this.socialLinks,
    required this.address,
    required this.avatar,
    required this.banner,
  });
}