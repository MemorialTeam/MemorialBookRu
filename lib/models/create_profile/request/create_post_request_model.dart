import 'dart:io';
import 'package:memorial_book/helpers/constants.dart';

class CreatePostRequestModel {
  final int communityId;
  final String title;
  final String description;
  final List postMedia;
  final bool isPinned;
  final String publishedAt;

  CreatePostRequestModel({
    required this.communityId,
    required this.title,
    required this.description,
    required this.postMedia,
    required this.isPinned,
    required this.publishedAt,
  });
}