import '../../common/coords_request.dart';

class CreatingCemeteryRequestModel {
  final String title;
  final String subtitle;
  final String address;
  final CoordsRequest addressCoords;
  final String email;
  final String phone;
  final String? schedule;
  final String? description;
  final String access;
  final String asDraft;

  CreatingCemeteryRequestModel({
    required this.title,
    required this.subtitle,
    required this.address,
    required this.addressCoords,
    required this.email,
    required this.phone,
    required this.schedule,
    required this.description,
    required this.access,
    required this.asDraft,
  });
}
