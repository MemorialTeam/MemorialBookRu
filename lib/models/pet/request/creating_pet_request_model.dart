class CreatingPetRequestModel {
  final String name;
  final String breed;
  final String dateBirth;
  final String dateDeath;
  final String deathReason;
  final String birthPlace;
  final String? ownerID;
  final String description;
  final String access;
  final String asDraft;

  CreatingPetRequestModel({
    required this.name,
    required this.breed,
    required this.dateBirth,
    required this.dateDeath,
    required this.deathReason,
    required this.birthPlace,
    required this.ownerID,
    required this.description,
    required this.access,
    required this.asDraft,
  });
}