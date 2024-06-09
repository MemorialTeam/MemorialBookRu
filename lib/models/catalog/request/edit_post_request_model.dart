import '../../../helpers/enums.dart';

class EditPostRequestModel {
  final int postId;
  final int communityId;
  final PostContentType contentType;
  final String? title;
  final String? description;
  final List<dynamic>? postMedia;
  final List<String>? postMediaRemovedIds;
  final String method = 'PUT';

  EditPostRequestModel({
    required this.postId,
    required this.communityId,
    required this.contentType,
    this.title,
    this.description,
    this.postMedia,
    this.postMediaRemovedIds,
  });
}