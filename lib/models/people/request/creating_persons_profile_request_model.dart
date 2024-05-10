import 'package:memorial_book/models/common/coords_request.dart';

class CreatingPersonsProfileRequestModel {
  final String firstName;
  final String lastName;
  final String? middleName;
  final String gender;
  final String dateBirth;
  final String dateDeath;
  final String? deathReason;
  final String birthPlace;
  final String? fatherID;
  final String? motherID;
  final String? spouseID;
  final String description;
  final CoordsRequest coords;
  final String access;
  final int? religion;
  final String asDraft;
  final int? cemeteryId;

  CreatingPersonsProfileRequestModel({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.gender,
    required this.dateBirth,
    required this.dateDeath,
    required this.deathReason,
    required this.birthPlace,
    required this.fatherID,
    required this.motherID,
    required this.spouseID,
    required this.description,
    required this.coords,
    required this.access,
    required this.religion,
    required this.asDraft,
    required this.cemeteryId,
  });
}