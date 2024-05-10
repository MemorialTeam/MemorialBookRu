class SearchPeopleRequestModel {
  String? fullName;
  String? birthYearFrom;
  String? birthYearTo;
  String? deathYearFrom;
  String? deathYearTo;
  String? country;

  SearchPeopleRequestModel({
    required this.fullName,
    required this.birthYearFrom,
    this.birthYearTo,
    required this.deathYearFrom,
    this.deathYearTo,
    required this.country,
  });
}