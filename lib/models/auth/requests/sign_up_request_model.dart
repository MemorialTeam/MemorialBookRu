class SignUpRequestModel {
  final String? username;
  final String email;
  final String password;
  final String? passwordConfirmation;
  final String fcmToken;
  final String deviceName;
  final String? location;

  SignUpRequestModel({
    this.username,
    required this.email,
    required this.password,
    this.passwordConfirmation,
    required this.fcmToken,
    required this.deviceName,
    this.location,
  });
}
