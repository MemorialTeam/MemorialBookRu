import '../../../helpers/enums.dart';

class NotificationDataResponseModel {
  int? id;
  bool? isViewed;
  NotificationType? type;
  String? title;
  String? description;
  String? avatar;
  String? image;

  NotificationDataResponseModel({
    required this.id,
    required this.isViewed,
    required this.type,
    required this.title,
    required this.description,
    required this.avatar,
    required this.image,
  });

  NotificationDataResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isViewed = json['is_viewed'];
    switch(json['type']) {
      case 'info':
        type = NotificationType.info;
        break;
      default:
        type = NotificationType.none;
        break;
    }
    title = json['title'];
    description = json['description'];
    avatar = json['avatar'];
    image = json['image'];
  }
}
