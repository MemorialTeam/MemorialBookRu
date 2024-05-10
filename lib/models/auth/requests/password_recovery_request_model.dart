class PasswordRecoveryRequestModel {
  final String email;
  final String password;
  final String passwordConfirmation;
  final String verificationCode;

  PasswordRecoveryRequestModel({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.verificationCode,
  });
}