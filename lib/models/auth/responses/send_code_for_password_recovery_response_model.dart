class SendCodeForPasswordRecoveryResponseModel {
  bool? status;
  dynamic verificationCode;
  String? message;

  SendCodeForPasswordRecoveryResponseModel({
    required this.status,
    required this.verificationCode,
    required this.message,
  });

  SendCodeForPasswordRecoveryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['verification_code'] != null) {
      verificationCode = json['verification_code'];
    }
    message = json['message'];
  }
}