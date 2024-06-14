class GetNotificationCountResponse {
  bool? status;
  int? count;

  GetNotificationCountResponse({
    required this.status,
    required this.count,
  });

  GetNotificationCountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
  }
}