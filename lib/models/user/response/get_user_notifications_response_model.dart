import 'package:memorial_book/models/common/links_reponse_model.dart';
import 'notification_data_response_model.dart';

class GetUserNotificationsResponseModel {
  bool? status;
  List<NotificationDataResponseModel>? data;
  LinksResponseModel? links;

  GetUserNotificationsResponseModel({
    required this.status,
    required this.links,
  });

  GetUserNotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['status'] == true) {
      data = List.from(json['events']['data']).map(
        ((index) => NotificationDataResponseModel.fromJson(index)),
      ).toList();
      links = LinksResponseModel.fromJson(json['events']['links']);
    }
  }
}

