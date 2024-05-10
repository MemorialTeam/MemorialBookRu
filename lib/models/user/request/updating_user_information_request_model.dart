import 'dart:io';
import 'package:http/http.dart';

class UpdatingUserInformationRequestModel {
  final String username;
  final String email;
  final String? password;
  final String? passwordConfirmation;
  final File? avatar;

  UpdatingUserInformationRequestModel({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    this.avatar,
  });
}